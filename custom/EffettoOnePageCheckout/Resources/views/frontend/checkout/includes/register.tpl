<div class="panel register--personal register--content">
  {if !$isUpdate}
    <h2 class="panel--title is--underline {if $registerData}is--active{/if}" id="opc-register-link" data-collapsetarget="#opc-register" data-closeSiblings="true">{s namespace='frontend/register/personal_fieldset' name='RegisterPersonalMarketingHeadline'}{/s}</h2>
  {/if}

  <form id="opc-register" class="js--collapse-target {if $registerData}is--collapsed{/if}" class="register--form" action="{url controller='Register' action='saveRegister' sTarget='checkout' sTargetAction='index'}" method="post">
    {include file="frontend/register/error_message.tpl" error_messages=$errors.personal}
    {include file="frontend/checkout/includes/personal_fieldset.tpl" form_data=$registerData.personal error_flags=$errors.personal}
    {include file="frontend/register/error_message.tpl" error_messages=$errors.billing}
    {include file="frontend/checkout/includes/billing_fieldset.tpl" form_data=$registerData.billing error_flags=$errors.billing country_list=$country_list}

    {if !$AdditionalShippingDisable}
      {include file="frontend/register/error_message.tpl" error_messages=$errors.shipping}
      {include file="frontend/checkout/includes/shipping_fieldset.tpl" form_data=$registerData.shipping error_flags=$errors.shipping country_list=$country_list}
    {/if}

    {* Privacy checkbox *}
    {if !$isUpdate}
      {if {config name=ACTDPRCHECK}}
        {block name='frontend_register_index_input_privacy'}
          <div class="panel--body is--wide register--privacy">
            <input name="register[personal][dpacheckbox]" type="checkbox" id="dpacheckbox"{if $form_data.dpacheckbox} checked="checked"{/if} required="required" aria-required="true" value="1" class="chkbox is--required" />
            <label for="dpacheckbox" class="chklabel{if isset($errors.personal.dpacheckbox)} has--error{/if}">{s namespace='frontend/register/index' name='RegisterLabelDataCheckbox'}{/s}</label>
          </div>
        {/block}
      {/if}
    {/if}
    <div class="panel--body is--wide">
      <div class="action">
        <button class="register-btn btn is--primary is--large is--icon-right" type="submit" name="Submit">{s name="EffettoOnePageCheckoutRegister"}Weiter{/s}<i class="icon--arrow-right"></i></button>
      </div>
    </div>
  </form>
</div>