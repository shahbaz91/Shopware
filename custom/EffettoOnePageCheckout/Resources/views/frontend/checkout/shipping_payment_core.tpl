{extends file="parent:frontend/checkout/shipping_payment_core.tpl"}

{block name='frontend_checkout_shipping_payment_core_footer'}{/block}

{*{block name='frontend_checkout_shipping_payment_core_buttons'}{/block}*}

{* Block zu Verwendung in Drittanbieter Plugins/ Themes *}
{block name="frontend_checkout_footer_addons" append}
  <div class="pp--approval-url is--hidden">{$PaypalPlusApprovalUrl}</div>
  {if $sUserData.additional.payment.id == $PayPalPaymentId && $PaypalPlusApprovalUrl}
    {include file="frontend/payment_paypal_plus/js-payment_wall.tpl"}
  {/if}
{/block}

{block name="frontend_checkout_footer"}
  <div class="pp--approval-url is--hidden">{$PaypalPlusApprovalUrl}</div>
  {if $sUserData.additional.payment.id == $PayPalPaymentId && $PaypalPlusApprovalUrl}
    {include file="frontend/payment_paypal_plus/js-payment_wall.tpl"}
  {/if}
{/block}
