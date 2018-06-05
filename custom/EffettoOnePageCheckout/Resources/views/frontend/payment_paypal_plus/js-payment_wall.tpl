{block name="frontend_checkout_payment_paypalplus_paymentwall"}
    {$PayPalPlusContinue = "{s name='PaypalPlusLinkChangePayment'}Weiter{/s}"}
    <script type="text/javascript">
      var jQuery_SW = $.noConflict(true);
    </script>
    <script src="https://www.paypalobjects.com/webstatic/ppplus/ppplus.min.js" type="text/javascript"></script>
    <script type="text/javascript">

      var jQuery = $ = jQuery_SW;
      window.paypalIsCurrentPaymentMethodPaypal = {if $sUserData.additional.payment.id == $PayPalPaymentId}true{else}false{/if};

      function paymentWall($, approvalUrl) {
        var $basketButton = $('#basketButton'),
                bbFunction = 'val',
                $agb = $('#sAGB'),
                ppp,
                preSelection = 'none',
                $payPalCheckBox = $("#payment_mean" + {$PayPalPaymentId}),
                isConfirmAction = $('.is--act-confirm').length > 0,
                urlForSendingCustomerData = '{url controller=checkout action=preRedirect forceSecure}',
                urlForSendingCustomerDataError  = '{url controller=payment_paypal action=return forceSecure}',

                onConfirm = function(event) {
                  if (!window.paypalIsCurrentPaymentMethodPaypal || ($agb && $agb.length > 0 && !$agb.prop('checked'))) {
                    return;
                  }

                  event.preventDefault();

                  $.ajax({
                    type: "POST",
                    url: urlForSendingCustomerData,
                    success: function() {
                      ppp.doCheckout();
                    },
                    error: function() {
                      $(location).attr('href', urlForSendingCustomerDataError);
                    }
                  });
                };

        approvalUrl = approvalUrl || "{$PaypalPlusApprovalUrl|escape:javascript}";

        if (!$basketButton[0]) {
          $basketButton = $('.main--actions button[type=submit]');
          bbFunction = 'html';
        }

        $basketButton.data('orgValue', $basketButton[bbFunction]());

        $('#confirm--form').on('submit', onConfirm);
        $basketButton.on('click', onConfirm);

        if (!$('#ppplus').length) {
          return;
        }

        if ($payPalCheckBox.length > 0 && $payPalCheckBox.prop('checked')) {
          preSelection = 'paypal';
        } else if (isConfirmAction && window.paypalIsCurrentPaymentMethodPaypal) {
          preSelection = 'paypal'
        }

        ppp = PAYPAL.apps.PPP({
          approvalUrl: approvalUrl,
          placeholder: "ppplus",
          mode: "{if $PaypalPlusModeSandbox}sandbox{else}live{/if}",
          buttonLocation: "outside",
          useraction: "commit",
          country: '{$sUserData.additional.country.countryiso}',
          {if $PaypalLocale == 'de_DE' || $PaypalLocale == 'de_AT'}
          {$PaypalPlusLang = 'DE_de'}
          {elseif $PaypalLocale == 'en_US' || $PaypalLocale == 'en_GB'}
          {$PaypalPlusLang = 'US_en'}
          {else}
          {$PaypalPlusLang = $PaypalLocale}
          {/if}
          language: '{$PaypalPlusLang}',
          preselection: preSelection,
          showPuiOnSandbox: true,
          showLoadingIndicator: true
        });

        return ppp;
      }

      jQuery(document).ready(function ($) {
        $.subscribe('plugin/opcPayment/onPaymentLoad', function() {
          paymentWall($);

          $( window ).resize(function() {
            $('#ppplus iframe').width('100%');
          });
        });
      });
    </script>
{/block}
