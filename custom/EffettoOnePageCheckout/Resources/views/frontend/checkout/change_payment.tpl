{extends file="parent:frontend/checkout/change_payment.tpl"}

{* Radio Button *}
{block name='frontend_checkout_payment_fieldset_input_radio'}
    <div class="method--input">
        <input type="radio" name="payment" class="radio auto_submit{if $payment_mean.redirectToPaymentPage} redirect--to-payment-page{/if}" value="{$payment_mean.id}" id="payment_mean{$payment_mean.id}"{if $payment_mean.id eq $sFormData.payment or (!$sFormData && !$smarty.foreach.register_payment_mean.index)} checked="checked"{/if} />
    </div>
{/block}

{* Method Name *}
{block name='frontend_checkout_payment_fieldset_input_label'}
  <div class="method--label is--first">
    <label class="method--name is--strong" for="payment_mean{$payment_mean.id}">
      {$payment_mean.description}<a href="{url action='shippingPayment'}" class="more--shipping-payment-link">{s name='EffettoOnePageCheckoutPaymentDetails'}Details{/s}</a>
    </label>
  </div>
{/block}
