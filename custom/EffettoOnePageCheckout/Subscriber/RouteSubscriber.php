<?php
namespace EffettoOnePageCheckout\Subscriber;
use Doctrine\Common\Collections\ArrayCollection;
use Enlight\Event\SubscriberInterface;
use Enlight_Hook_HookArgs;
use Enlight_Template_Manager;
use Shopware\Components\Plugin\ConfigReader;
use Shopware\Components\Theme\LessDefinition;
use ArrayObject;

class RouteSubscriber implements SubscriberInterface
{
    private $templateManager;

    private $pluginDirectory;

    private $config;

    //constructor/initializer for subscriber
    public function __construct(
        Enlight_Template_Manager $templateManager,
        $pluginName,
        $pluginDirectory,
        ConfigReader $configReader
    )
    {
        $this->templateManager = $templateManager;
        $this->pluginDirectory = $pluginDirectory;
        $this->config = $configReader->getByPluginName($pluginName);
    }

    //events array
    public static function getSubscribedEvents()
    {
        return [
            //'Enlight_Bootstrap_AfterInitResource_shopware_account.address_validator'    => 'replaceAddressValidatorService',
            'Theme_Compiler_Collect_Plugin_Less'                                        => 'addLessFiles',
            'Theme_Compiler_Collect_Plugin_Javascript'                                  => 'addJsFiles',
            'Enlight_Controller_Action_PostDispatchSecure_Frontend_Register'            => 'onPostDispatch',
            'Enlight_Controller_Action_PreDispatch_Frontend_Checkout'                   => 'onPreDispatchCheckout',
            'Enlight_Controller_Action_PostDispatchSecure_Frontend_Checkout'            => 'onPostDispatchCheckout',
            'sAdmin::sCheckUser::after'                                                 => 'afterCheckUser',
            'Shopware_Controllers_Frontend_Checkout::saveTemporaryOrder::replace'       => 'replaceSaveTemporaryOrder',
            'Enlight_Controller_Action_PostDispatchSecure_Frontend_PaymentPaypal'                   => 'onPostDispatchPaymentPaypalCancelAction',
        ];
    }

    /*public function replaceAddressValidatorService()
    {
        $coreService = Shopware()->Container()->get('shopware_account.address_validator');
        $addressValidatorService = new \Shopware\EffettoOnePageCheckout\Service\AddressValidator($coreService);
        Shopware()->Container()->set('shopware_account.address_validator', $addressValidatorService);
    }*/

    /**
     * Provide the file collection for js files
     *
     * @param Enlight_Event_EventArgs $args
     * @return \Doctrine\Common\Collections\ArrayCollection
     */
    public function addJsFiles(\Enlight_Event_EventArgs $args)
    {
        $jsFiles = array(
            $this->pluginDirectory . '/Resources/views/frontend/_resources/src/js/jquery.opc.js',
        );
        return new ArrayCollection($jsFiles);
    }

    /**
     * Provide the file collection for less files
     *
     * @param Enlight_Event_EventArgs $args
     * @return \Doctrine\Common\Collections\ArrayCollection
     */
    public function addLessFiles(\Enlight_Event_EventArgs $args)
    {
        $less = new LessDefinition(
            array(),
            array($this->pluginDirectory . '/Resources/views/frontend/_resources/src/less/opc.less'),
            $this->pluginDirectory
        );
        return new ArrayCollection(array($less));
    }

    /**
     * @param \Enlight_Event_EventArgs $args
     */
    public function onPostDispatch(Enlight_Event_EventArgs $args)
    {
        $controller = $args->getSubject();
        $request = $controller->Request();
        $action = $request->getActionName();
        $view = $controller->View();
        if ((($action == 'index') || ($action == 'saveRegister')) && (($request->getParam('sTargetAction') == 'confirm') || ($request->getParam('sTargetAction') == 'index')) && ($request->getParam('sTarget') == 'checkout')) {
            return Shopware()->Session()->errors = $view->errors;

            return Shopware()->Session()->register = $view->register;
            return $controller->redirect( array(
                'action'     => 'confirm',
                'controller' => 'checkout'
            ));
        }
    }

    public function onPostDispatchPaymentPaypalCancelAction(Enlight_Event_EventArgs $args)
    {
        $controller = $args->getSubject();
        $request = $controller->Request();
        $action = $request->getActionName();

        if ($action != 'cancel') {
            return;
        }

        if ($this->config['PayPalRedirect']) {
            $args->getSubject()->forward('confirm', 'checkout');
        }
    }

    /**
     * @param \Enlight_Hook_HookArgs $args
     */
    public function afterCheckUser(Enlight_Hook_HookArgs $args)
    {
        if (!(isset($this->request))) {
            return;
        }

        if ($this->request->getActionName() === 'confirm') {
            $args->setReturn(true);
        }
    }

    /**
     * @param \Enlight_Hook_HookArgs $args
     */
    public function replaceSaveTemporaryOrder(Enlight_Hook_HookArgs $args)
    {
        $controller = $args->getSubject();
        $this->request = $controller->Request();
        $this->view = $controller->View();

        if (Shopware()->Session()->sUserId) {
            $args->getSubject()->executeParent('saveTemporaryOrder');
        }
    }

    /**
     * @param \Enlight_Event_EventArgs $args
     */
    public function onPreDispatchCheckout(Enlight_Event_EventArgs $args)
    {
        $controller = $args->getSubject();
        $this->request = $controller->Request();
        $action = $this->request->getActionName();
        $this->view = $controller->View();
        $session = Shopware()->Session();
        $session->offsetSet('PayPalPlusCameFromStep2', 'step2');

        if (!($session->offsetGet('checkoutBillingAddressId')) && !($session->offsetGet('checkoutShippingAddressId'))) {
            $session->offsetSet('checkoutBillingAddressId', 1);
            $session->offsetSet('checkoutShippingAddressId', 1);
        }

        if (($action == 'shippingPayment') && !(Shopware()->Session()->sUserId)) {
            return $controller->forward('confirm', 'checkout', null);
        }

        if (($action != 'confirm') && ($action != 'shippingPayment')) {
            return;
        }

        $getCountryList = Shopware()->Modules()->Admin()->sGetCountryList();
        $this->view->country_list = $getCountryList;
        $this->view->register = new ArrayObject(array(), ArrayObject::ARRAY_AS_PROPS);
        $this->view->register->billing = new ArrayObject(array(), ArrayObject::ARRAY_AS_PROPS);
        $this->view->register->billing->country_list = $getCountryList;
        $this->view->register->shipping = new ArrayObject(array(), ArrayObject::ARRAY_AS_PROPS);
        $this->view->register->shipping->country_list = $getCountryList;
        $this->request->setParam('payment', $this->request->get('sPayment'));

        $this->view->useStepsOnlyVertical = $this->config['useStepsOnlyVertical'];
        $this->view->AgbOnTop = $this->config['AgbOnTop'];
        $this->view->registerBeforeLogin = $this->config['registerBeforeLogin'];
    }

    protected function loadAndAssignShippingPaymentData($args)
    {
        $controller = $args->getSubject();
        $request = $controller->Request();
        $action = $request->getActionName();
        $view = $controller->View();
        $admin = Shopware()->Modules()->Admin();
        $session = Shopware()->Session();
        $view->sFormData = array('payment' => $view->sUserData['additional']['user']['paymentID']);
        $getPaymentDetails = $admin->sGetPaymentMeanById($view->sFormData['payment']);
        $paymentClass = $admin->sInitiatePaymentClass($getPaymentDetails);

        if ($paymentClass instanceof \ShopwarePlugin\PaymentMethods\Components\BasePaymentMethod) {
            $data = $paymentClass->getCurrentPaymentDataAsArray(Shopware()->Session()->sUserId);

            if (!(empty($data))) {
                $view->sFormData += $data;
            }
        }

        if ($request->isPost()) {
            $values = $request->getPost();
            $values['payment'] = $request->getPost('payment');
            $values['isPost'] = true;
            $view->sFormData = $values;
        }

        $view->sDispatches = $controller->getDispatches($view->sFormData['payment']);
        $view->sShippingcosts = $view->sBasket['sShippingcosts'];
        $view->sShippingcostsDifference = $view->sBasket['sShippingcostsDifference'];
        $view->sAmount = $view->sBasket['sAmount'];
        $view->sAmountWithTax = $view->sBasket['sAmountWithTax'];
        $view->sAmountTax = $view->sBasket['sAmountTax'];
        $view->sAmountNet = $view->sBasket['AmountNetNumeric'];
        $view->sRegisterFinished = !(empty($session['sRegisterFinished']));
        $view->sTargetAction = 'shippingPayment';
        $view->sPaymentMeans = $admin->sGetPaymentMeans();
        $view->sFormData = array('payment' => $view->sUserData['additional']['user']['paymentID']);
        $view->sTarget = $request->getParam('sTarget', $request->getControllerName());
        $view->sTargetAction = $request->getParam('sTargetAction', 'index');
        $getPaymentDetails = $admin->sGetPaymentMeanById($view->sFormData['payment']);
        $paymentClass = $admin->sInitiatePaymentClass($getPaymentDetails);

        if ($paymentClass instanceof \ShopwarePlugin\PaymentMethods\Components\BasePaymentMethod) {
            $data = $paymentClass->getCurrentPaymentDataAsArray(Shopware()->Session()->sUserId);

            if (!(empty( $data ))) {
                $view->sFormData += $data;
            }
        }
    }

    /**
     * @param \Enlight_Event_EventArgs $args
     */
    public function onPostDispatchCheckout(Enlight_Event_EventArgs $args)
    {
        $controller = $args->getSubject();
        $request = $controller->Request();
        $action = $request->getActionName();
        $view = $controller->View();
        $admin = Shopware()->Modules()->Admin();

        $view->addTemplateDir($this->pluginDirectory . '/Resources/views');

        if (($action != 'confirm') && ($action != 'shippingPayment')) {
            return;
        }

        if (Shopware()->Session()->register) {
            $view->registerData = Shopware()->Session()->register;
            return Shopware()->Session()->register = false;
        }

        if (Shopware()->Session()->loginDataError) {
            $view->loginDataError = Shopware()->Session()->loginDataError;
            return Shopware()->Session()->loginDataError = false;
        }

        if (Shopware()->Session()->sErrorFlag || Shopware()->Session()->sErrorMessages) {
            $view->sErrorFlag = Shopware()->Session()->sErrorFlag;
            $view->sErrorMessages = Shopware()->Session()->sErrorMessages;
            return Shopware()->Session()->sErrorFlag = false;
            return Shopware()->Session()->sErrorMessages = false;
        }

        if (Shopware()->Session()->errors) {
            $view->errors = Shopware()->Session()->errors;
            return Shopware()->Session()->errors = false;
        }

        $view->assign('sUserLoggedIn', Shopware()->Session()->sUserId);
        $view->sPaymentMeans = $admin->sGetPaymentMeans();
        $view->sFormData = array('payment' => $view->sUserData['additional']['user']['paymentID']);
        $view->sTarget = $request->getParam('sTarget', $request->getControllerName());
        $view->sTargetAction = $request->getParam('sTargetAction', 'index');
        $view->assign('config', Shopware()->Config());
        $getPaymentDetails = $admin->sGetPaymentMeanById($view->sFormData['payment']);
        $paymentClass = $admin->sInitiatePaymentClass($getPaymentDetails);

        if ($paymentClass instanceof \ShopwarePlugin\PaymentMethods\Components\BasePaymentMethod) {
            $data = $paymentClass->getCurrentPaymentDataAsArray(Shopware()->Session()->sUserId);

            if (!(empty($data))) {
                $view->sFormData += $data;
            }
        }

        if ($request->isPost()) {
            $values = $request->getPost();
            $values['payment'] = $request->getPost('register');
            $values['payment'] = $values['payment']['payment'];
            $values['isPost'] = true;
            $view->sFormData = $values;
        }

        $this->loadAndAssignShippingPaymentData($args);

        if ($action == 'shippingPayment') {
            if ($request->getPost('isXHR')) {
                //$this->bootstrap->Application()->Template()->addTemplateDir($this->bootstrap->Path() . 'Views/' );
                $view->addTemplateDir($this->pluginDirectory . '/Resources/views');
                $view->extendsTemplate('frontend/checkout/shipping_payment_core.tpl');
            }
        }

        if ($this->config['OpcPaymentsRedirectToPaymentPage']) {
            $paymentRedirects = explode(',', str_replace(' ', '', $this->config['OpcPaymentsRedirectToPaymentPage']));
            if (!(is_array($paymentRedirects)) || (count($paymentRedirects) == 0)) {
                return;
            }

            $sPayments = $view->sPayments;

            foreach ($sPayments as &$payment) {
                if (in_array($payment['id'], $paymentRedirects)) {
                    $payment['redirectToPaymentPage'] = 1;
                }
            }

            $view->sPayments = $sPayments;
        }

        $view->assign('ShowPremiumProductArea', $this->config['ShowPremiumProductArea']);
        $view->assign('AdditionalShippingDisable', $this->config['AdditionalShippingDisable']);
    }
}