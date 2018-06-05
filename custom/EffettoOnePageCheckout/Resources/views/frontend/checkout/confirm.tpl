{extends file="parent:frontend/checkout/confirm.tpl"}

{block name='frontend_index_navigation_categories_top'}{/block}

{* Main content *}
{block name='frontend_index_content'}
  <div id="one-page-checkout" {if $useStepsOnlyVertical}class="only-vertical"{/if}>
    <h1>{s name="EffettoOnePageCheckoutOrder"}Bestellung{/s}</h1>
    <p>{s name="EffettoOnePageCheckoutOrderInfo"}Bitte füllen Sie die nachfolgenden Felder aus, um die Bestellung abzuschließen.{/s}</p>

    {* Error messages *}
    {block name='frontend_checkout_confirm_error_messages'}
      {include file="frontend/checkout/error_messages.tpl"}
    {/block}

    {if $AgbOnTop}
      <div class="agb--on-top panel has--border {if !$sUserLoggedIn}is--hidden{/if}">
        {include file='frontend/checkout/includes/agb_and_revocation.tpl'}
      </div>
    {/if}

    <div class="register--personal-data panel has--border">
      <h2><span class="step-icon{if $sUserLoggedIn} step--done{/if}">1</span> {s name="EffettoOnePageCheckoutPersonalData"}Persönliche Daten{/s}</h2>

      {if !$sUserLoggedIn}
        {if $registerBeforeLogin}
          {include file="frontend/checkout/includes/register.tpl"}
          {include file="frontend/checkout/includes/login.tpl"}
        {else}
          {include file="frontend/checkout/includes/login.tpl"}
          {include file="frontend/checkout/includes/register.tpl"}
        {/if}

        {if $bestitAmazonPaymentsAdvanced.displayCartButton.display}
          <br />
          {if !$bestitAmazonPaymentsAdvancedDisplay}
            {assign var=bestitAmazonPaymentsAdvancedDisplay value=1}
          {else}
            {capture assign=bestitAmazonPaymentsAdvancedDisplay}{$bestitAmazonPaymentsAdvancedDisplay+1}{/capture}
          {/if}
          {if $bestitAmazonPaymentsAdvanced.type > 1}
            {include file='frontend/amazon_payments_advanced/amazon_button_login_and_pay.tpl' bestitAmazonPaymentsTimeout=1 bestitAmazonPaymentsCssClass="left cart_action btn--checkout-proceed {if $bestitAmazonPaymentsAdvanced.paypalCart} amazon_vs_paypal{else} amazon_only{/if}" bestitAmazonPaymentsAdvancedDisplay=$bestitAmazonPaymentsAdvancedDisplay bestitAmazonPaymentsAdvancedButtonType=$bestitAmazonPaymentsAdvanced.displayCartButton.pay bestitAmazonPaymentsAdvancedButtonSize=$bestitAmazonPaymentsAdvanced.displayCartButton.size bestitAmazonPaymentsAdvancedButtonColor=$bestitAmazonPaymentsAdvanced.displayCartButton.color bestitAmazonPaymentsAdvancedTarget=address}
          {else}
            {include file='frontend/amazon_payments_advanced/amazon_button_pay_only.tpl' bestitAmazonPaymentsTimeout=1 bestitAmazonPaymentsCssClass="left cart_action btn--checkout-proceed {if $bestitAmazonPaymentsAdvanced.paypalCart} amazon_vs_paypal{else} amazon_only{/if}" bestitAmazonPaymentsAdvancedDisplay=$bestitAmazonPaymentsAdvancedDisplay bestitAmazonPaymentsAdvancedButtonSize=$bestitAmazonPaymentsAdvanced.displayCartButton.size bestitAmazonPaymentsAdvancedButtonColor=$bestitAmazonPaymentsAdvanced.displayCartButton.color}
          {/if}
          <br />
        {/if}

        {if $BestitIsHttps}
          {if $bestitAmazonPay.displayCartButton.display}
            <br />
            {if !$bestitAmazonPayDisplay}
              {assign var=bestitAmazonPayDisplay value=1}
            {else}
              {capture assign=bestitAmazonPayDisplay}{$bestitAmazonPayDisplay+1}{/capture}
            {/if}
            {include file='frontend/amazon_pay/amazon_button_login_and_pay.tpl' bestitAmazonPaymentsCssClass="cart_action amazon_cart_top btn--checkout-proceed right{if $bestitAmazonPay.paypalCart} amazon_vs_paypal{else} amazon_only{/if}" bestitAmazonPayDisplay=$bestitAmazonPayDisplay bestitAmazonPayButtonType=$bestitAmazonPay.displayCartButton.pay bestitAmazonPayButtonSize=$bestitAmazonPay.displayCartButton.size bestitAmazonPayButtonColor=$bestitAmazonPay.displayCartButton.color bestitAmazonPayTarget=address}
            <br />
          {/if}
        {/if}

        {if $PaypalShowButton}
          <br />
          {* PayPal express button *}
          <a href="{url controller=payment_paypal action=express forceSecure}"
             title="{s name='PaypalButtonLinkTitleText'}{/s}"
             class="paypal-express--btn">
            {if !$PaypalLocale || $PaypalLocale == 'de_DE'}
              <img width="146" srcset="{link file='../../../SwagPaymentPaypal/Views/responsive/frontend/_public/src/img/paypal-button-express-de.png'}, {link file='frontend/_public/src/img/paypal-button-express-de-2x.png'} 2x"
                   alt="{s name='PaypalButtonAltText'}{/s}">
            {elseif $PaypalLocale|strpos:"en" !== false}
              <img width="146" src="{link file='../../../SwagPaymentPaypal/Views/responsive/frontend/_public/src/img/paypal-button-express-en.png'}"
                   alt="{s name='PaypalButtonAltText'}{/s}">
            {else}
              <img width="146" src="https://www.paypal.com/{$PaypalLocale}/i/btn/btn_xpressCheckout.gif"
                   alt="{s name='PaypalButtonAltText'}{/s}">
            {/if}
          </a>
        {/if}
        <br />
      {else}
        {* add/ change/ select billingaddress and shippingaddress *}
        {include file="frontend/checkout/includes/billing_and_shipping_data.tpl"}

        <div class="panel--body is--wide right">
          <a href="{url controller='account' action='logout'}">Logout</a>
        </div>
      {/if}


    </div>
    <div class="register--shipment-and-payment content--confirm panel has--border {if !$sUserLoggedIn}not-logged-in{/if}">
      <h2><span class="step-icon">2</span> {s name="EffettoOnePageCheckoutShippingPaymentMethod"}Zahlweise und Versand{/s}</h2>

      {*<form id="shippingPaymentForm" name="shippingPaymentForm" method="post" action="{url controller='EffettoOnePageCheckout' action='saveShippingPayment'}" class="payment">*}
      <div class="shipping-payment--information">
        {* Payment fieldset *}
        <div class="confirm--inner-container block">
          {block name="frontend_account_payment_form_content"}
            {if $sBasket.content}
              {if $sUserLoggedIn}
                <input type="hidden" name="opc--more-payments-url" id="#opc--more-payments-url" value="{url controller='checkout' action='shippingPayment'}" />
                <div id="opc-change-payment-area" data-payment="{$sFormData.payment}" data-url="{url controller='checkout' action='shippingPayment'}">
                  <div class="js--loading-indicator" style="display: block;"><div class="icon--default"></div></div>
                </div>
              {else}
                {include file='frontend/checkout/includes/change_payment.tpl' form_data=$sFormData error_flags=$sErrorFlag payment_means=$sPaymentMeans}
                {include file='frontend/checkout/includes/change_shipping_method.tpl' form_data=$sFormData error_flags=$sErrorFlag}
              {/if}
            {/if}
          {/block}
        </div>
      </div>
      {*</form>*}

    </div>
    <div class="register--overview panel has--border {if !$sUserLoggedIn}not-logged-in{/if}">
      <h2><span class="step-icon">3</span> {s name="EffettoOnePageCheckoutOrderOverview"}Bestellübersicht{/s}</h2>

      {include file='frontend/checkout/includes/articles_and_order.tpl'}

    </div>
  </div>

  {block name='frontend_checkout_cart_table'}
  {/block}

  {* Premium products *}
  {block name='frontend_checkout_cart_premium'}
    {if $sPremiums && $ShowPremiumProductArea}

      {* Actual listing *}
      {block name='frontend_checkout_cart_premium_products'}
        {include file='frontend/checkout/premiums.tpl'}
      {/block}
    {/if}
  {/block}
{/block}
