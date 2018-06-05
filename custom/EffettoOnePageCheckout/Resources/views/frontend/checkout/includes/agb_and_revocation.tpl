{* AGB and Revocation *}
{block name='frontend_checkout_confirm_tos_panel'}
  <div class="agb-and-revocation">

    {block name='frontend_checkout_confirm_tos_panel_headline'}
      <h2 class="panel--title is--underline">
        {s namespace='frontend/checkout/confirm' name="ConfirmHeadlineAGBandRevocation"}{/s}
      </h2>
    {/block}

    <div>

      {* Right of revocation notice *}
      {block name='frontend_checkout_confirm_tos_revocation_notice'}
        {if {config name=revocationnotice}}
          <div class="body--revocation" data-modalbox="true" data-targetSelector="a" data-mode="ajax" data-height="500" data-width="750">
            {s namespace='frontend/checkout/confirm' name="ConfirmTextRightOfRevocationNew"}<p>Bitte beachten Sie bei Ihrer Bestellung auch unsere <a href="{url controller=custom sCustom=8 forceSecure}" data-modal-height="500" data-modal-width="800">Widerrufsbelehrung</a>.</p>{/s}
          </div>
        {/if}
      {/block}

      {*<form id="confirm--form" method="post" action="{url controller='checkout' action='payment'}">*}
      <form id="confirm--form" method="post" action="{if $sPayment.embediframe || $sPayment.action}{url controller='checkout' action='payment'}{else}{url controller='checkout' action='finish'}{/if}">
        {* Hidden field for the user comment *}
        <textarea class="is--hidden user-comment--hidden" rows="1" cols="1" name="sComment">{$sComment|escape}</textarea>

        <ul class="list--checkbox list--unstyled">

          {* Terms of service *}
          {block name='frontend_checkout_confirm_agb'}
            <li class="block-group row--tos">
              {* Terms of service checkbox *}
              {block name='frontend_checkout_confirm_agb_checkbox'}
                <span class="block column--checkbox">
                                        {if !{config name='IgnoreAGB'}}
                                          <input type="checkbox" required="required" aria-required="true" id="sAGB" name="sAGB"{if $sAGBChecked} checked="checked"{/if} />
                                        {/if}
                                    </span>
              {/block}

              {* AGB label *}
              {block name='frontend_checkout_confirm_agb_label'}
                <span class="block column--label">
                                        <label for="sAGB"{if $sAGBError} class="has--error"{/if} data-modalbox="true" data-targetSelector="a" data-mode="ajax" data-height="500" data-width="750">{s namespace='frontend/checkout/confirm' name="ConfirmTerms"}{/s}</label>
                                    </span>
              {/block}
            </li>
          {/block}

          {* Service articles and ESD articles *}
          {block name='frontend_checkout_confirm_service_esd'}

            {* Service articles *}
            {block name='frontend_checkout_confirm_service'}
              {if $hasServiceArticles}
                <li class="block-group row--tos">

                  {* Service articles checkbox *}
                  {block name='frontend_checkout_confirm_service_checkbox'}
                    <span class="block column--checkbox">
												<input type="checkbox" required="required" aria-required="true" name="serviceAgreementChecked" id="serviceAgreementChecked"{if $serviceAgreementChecked} checked="checked"{/if} />
											</span>
                  {/block}

                  {* Service articles label *}
                  {block name='frontend_checkout_confirm_service_label'}
                    <span class="block column--label">
												<label for="swagCRDServiceBox"{if $agreementErrors && $agreementErrors.serviceError} class="has--error"{/if}>
                          {s name="AcceptServiceMessage"}{/s}
                        </label>
											</span>
                  {/block}
                </li>
              {/if}
            {/block}

            {* ESD articles *}
            {block name='frontend_checkout_confirm_esd'}
              {if $hasEsdArticles}
                <li class="block-group row--tos">

                  {* ESD articles checkbox *}
                  {block name='frontend_checkout_confirm_esd_checkbox'}
                    <span class="block column--checkbox">
												<input type="checkbox" required="required" aria-required="true" name="esdAgreementChecked" id="esdAgreementChecked"{if $esdAgreementChecked} checked="checked"{/if} />
											</span>
                  {/block}

                  {* ESD articles label *}
                  {block name='frontend_checkout_confirm_esd_label'}
                    <span class="block column--label">
												<label for="esdAgreementChecked"{if $agreementErrors && $agreementErrors.esdError} class="has--error"{/if}>
                          {s name="AcceptEsdMessage"}{/s}
                        </label>
											</span>
                  {/block}
                </li>
              {/if}
            {/block}

          {/block}

          {* Newsletter sign up checkbox *}
          {block name='frontend_checkout_confirm_newsletter'}
            {if !$sUserData.additional.user.newsletter && {config name=newsletter}}
              <li class="block-group row--newsletter">

                {* Newsletter checkbox *}
                {block name='frontend_checkout_confirm_newsletter_checkbox'}
                  <span class="block column--checkbox">
                                            <input type="checkbox" name="sNewsletter" id="sNewsletter" value="1"{if $sNewsletter} checked="checked"{/if} />
                                        </span>
                {/block}

                {* Newsletter label *}
                {block name='frontend_checkout_confirm_newsletter_label'}
                  <span class="block column--label">
                                            <label for="sNewsletter">
                                              {s namespace='frontend/checkout/confirm' name="ConfirmLabelNewsletter"}{/s}
                                            </label>
                                        </span>
                {/block}
              </li>
            {/if}
          {/block}
        </ul>
      </form>

      {* Additional custom text field which can be used to display the terms of services *}
      {block name="frontend_checkout_confirm_additional_free_text_display"}
        {if {config name=additionalfreetext}}
          <div class="notice--agb">
            {s namespace='frontend/checkout/confirm' name="ConfirmTextOrderDefault"}{/s}
          </div>
        {/if}
      {/block}

      {* Additional notice - bank connection *}
      {block name="frontend_checkout_confirm_bank_connection_notice"}
        {if {config name=bankConnection}}
          <p class="notice--change-now">
            {s namespace='frontend/checkout/confirm' name="ConfirmInfoChange"}{/s}
          </p>

          <p class="notice--payment-data">
            {s namespace='frontend/checkout/confirm' name="ConfirmInfoPaymentData"}{/s}
          </p>
        {/if}
      {/block}
    </div>
  </div>
{/block}