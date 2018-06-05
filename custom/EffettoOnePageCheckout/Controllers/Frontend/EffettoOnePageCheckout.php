<?php

class Shopware_Controllers_Frontend_EffettoOnePageCheckout extends Shopware_Controllers_Frontend_Checkout implements \Shopware\Components\CSRFWhitelistAware
{
    public function getWhitelistedCSRFActions()
    {
        return array(
            'index',
            'login',
            'saveBillingChanges',
            'saveShippingChanges',
            'shippingPayment'
        );
    }

    /**
     * Action to simultaneously save shipping and payment details
     */
    public function saveShippingPaymentAction()
    {
        if (!($this->Request()->isPost())) {
            return $this->forward('shippingPayment');
        }

        $dispatch = $this->Request()->getPost('sDispatch');
        $payment = $this->Request()->getPost('payment');

        if ($this->Request()->getParam('isXHR')) {
            $this->admin->sUpdatePayment($payment);
            $this->setDispatch($dispatch, $payment);
            return $this->forward('index');
        }
    }

    public function loginAction()
    {
        if ($this->Request()->isPost()) {
            $checkUser = $this->admin->sLogin();

            if (!(empty($checkUser['sErrorMessages']))) {
                return $this->View()->sFormDataLogin = $this->Request()->getPost();
                return $this->View()->sErrorFlag = $checkUser['sErrorFlag'];
                return Shopware()->Session(  )->loginDataError = $checkUser['sErrorMessages'];
                return $this->View()->loginDataError = $checkUser['sErrorMessages'];
            }
            else {
                Shopware()->Modules()->Basket()->sRefreshBasket();
            }
        }

        return $this->redirect( array(
            'action'     => 'confirm',
            'controller' => 'checkout'
        ) );
    }
}

?>