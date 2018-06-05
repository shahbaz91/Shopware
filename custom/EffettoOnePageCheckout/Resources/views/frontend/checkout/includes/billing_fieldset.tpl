<div class="panel register--company is--hidden">
	<div class="panel--body is--wide">
    {if !$isUpdate}
      <h3>{s namespace='frontend/register/billing_fieldset' name='RegisterHeaderCompany'}{/s}</h3>
    {/if}

		{* Company *}
		{block name='frontend_register_billing_fieldset_input_company'}
			<div class="register--companyname form-padding-bottom">
				<input autocomplete="section-billing billing organization" name="register[billing][company]" type="text" required="required" aria-required="true" placeholder="{s namespace='frontend/register/billing_fieldset' name='RegisterPlaceholderCompany'}{/s}{s name="RequiredField" namespace="frontend/register/index"}{/s}" id="register_billing_company" value="{$form_data.company|escape}" class="register--field is--required{if $error_flags.company} has--error{/if}" />
			</div>
		{/block}

		{* Department *}
		{block name='frontend_register_billing_fieldset_input_department'}
			<div class="register--department form-padding-bottom">
				<input autocomplete="section-billing billing organization-title" name="register[billing][department]" type="text" placeholder="{s namespace='frontend/register/billing_fieldset' name='RegisterLabelDepartment'}{/s}" id="register_billing_department" value="{$form_data.department|escape}" class="register--field" />
			</div>
		{/block}


    {* VAT Id *}
    {block name='frontend_register_billing_fieldset_input_vatId'}
      <div class="register--vatId">
        <input name="register[billing][vatId]"
               type="text" {if {config name=vatCheckRequired}} required="required" aria-required="true"{/if}
               placeholder="{s namespace='frontend/register/billing_fieldset' name='RegisterLabelTaxId'}{/s}{if {config name=vatcheckrequired}}{s name="RequiredField" namespace="frontend/register/index"}{/s}{/if}"
               id="register_billing_vatid"
               value="{$form_data.vatId|escape}"
                {if {config name=vatcheckrequired}} required="required" aria-required="true"{/if}
               class="register--field{if isset($error_flags.vatId)} has--error{/if}{if {config name=vatcheckrequired}} is--required{/if}"/>
      </div>
    {/block}
	</div>
</div>

<div class="panel register--address">
	<div class="panel--body is--wide">
    {if !$isUpdate}
      <h3>{s namespace='frontend/register/billing_fieldset' name='RegisterBillingHeadline'}{/s}</h3>
    {/if}

    {if $config->get('zipBeforeStreet')}
      {* Zip + City *}
      {block name='frontend_register_billing_fieldset_input_zip_and_city'}
        <div class="register--zip-city form-padding-bottom">
          {if {config name=showZipBeforeCity}}
            <input autocomplete="section-billing billing postal-code" name="register[billing][zipcode]" type="text" required="required" aria-required="true" placeholder="{s namespace='frontend/register/billing_fieldset' name='RegisterBillingPlaceholderZipcode'}{/s}{s name="RequiredField" namespace="frontend/register/index"}{/s}" id="zipcode" value="{$form_data.zipcode|escape}" class="register--field register--spacer register--field-zipcode is--required{if $error_flags.zipcode} has--error{/if}" />
            <input autocomplete="section-billing billing address-level2" name="register[billing][city]" type="text" required="required" aria-required="true" placeholder="{s namespace='frontend/register/billing_fieldset' name='RegisterBillingPlaceholderCity'}{/s}{s name="RequiredField" namespace="frontend/register/index"}{/s}" id="city" value="{$form_data.city|escape}" size="25" class="register--field register--field-city is--required{if $error_flags.city} has--error{/if}" />
          {else}
            <input autocomplete="section-billing billing address-level2" name="register[billing][city]" type="text" required="required" aria-required="true" placeholder="{s namespace='frontend/register/billing_fieldset' name='RegisterBillingPlaceholderCity'}{/s}{s name="RequiredField" namespace="frontend/register/index"}{/s}" id="city" value="{$form_data.city|escape}" size="25" class="register--field register--spacer register--field-city is--required{if $error_flags.city} has--error{/if}" />
            <input autocomplete="section-billing billing postal-code" name="register[billing][zipcode]" type="text" required="required" aria-required="true" placeholder="{s namespace='frontend/register/billing_fieldset' name='RegisterBillingPlaceholderZipcode'}{/s}{s name="RequiredField" namespace="frontend/register/index"}{/s}" id="zipcode" value="{$form_data.zipcode|escape}" class="register--field register--field-zipcode is--required{if $error_flags.zipcode} has--error{/if}" />
          {/if}
        </div>
      {/block}
    {/if}

		{* Street *}
		{block name='frontend_register_billing_fieldset_input_street'}
			<div class="register--street form-padding-bottom">
				<input autocomplete="section-billing billing street-address" name="register[billing][street]" type="text" required="required" aria-required="true" placeholder="{s namespace='frontend/register/billing_fieldset' name='RegisterBillingPlaceholderStreet'}{/s}{s name="RequiredField" namespace="frontend/register/index"}{/s}" id="street" value="{$form_data.street|escape}" class="register--field register--field-street is--required{if $error_flags.street} has--error{/if}" />
			</div>
		{/block}

		{* Additional Address Line 1 *}
		{block name='frontend_register_billing_fieldset_input_addition_address_line1'}
			{if {config name=showAdditionAddressLine1}}
				<div class="register--additional-line1 form-padding-bottom">
					<input autocomplete="section-billing billing address-line2" name="register[billing][additional_address_line1]" type="text"{if {config name=requireAdditionAddressLine1}} required="required" aria-required="true"{/if} placeholder="{s namespace='frontend/register/billing_fieldset' name='RegisterLabelAdditionalAddressLine1'}{/s}{if {config name=requireAdditionAddressLine1}}{s name="RequiredField" namespace="frontend/register/index"}{/s}{/if}" id="additionalAddressLine1" value="{$form_data.additional_address_line1|escape}" class="register--field{if {config name=requireAdditionAddressLine1}} is--required{/if}{if $error_flags.additional_address_line1 && {config name=requireAdditionAddressLine1}} has--error{/if}" />
				</div>
			{/if}
		{/block}

		{* Additional Address Line 2 *}
		{block name='frontend_register_billing_fieldset_input_addition_address_line2'}
			{if {config name=showAdditionAddressLine2}}
				<div class="register--additional-field2 form-padding-bottom">
					<input autocomplete="section-billing billing address-line3" name="register[billing][additional_address_line2]" type="text"{if {config name=requireAdditionAddressLine2}} required="required" aria-required="true"{/if} placeholder="{s namespace='frontend/register/billing_fieldset' name='RegisterLabelAdditionalAddressLine2'}{/s}{if {config name=requireAdditionAddressLine2}}{s name="RequiredField" namespace="frontend/register/index"}{/s}{/if}" id="additionalAddressLine2" value="{$form_data.additional_address_line2|escape}" class="register--field{if {config name=requireAdditionAddressLine2}} is--required{/if}{if $error_flags.additional_address_line2 && {config name=requireAdditionAddressLine2}} has--error{/if}" />
				</div>
			{/if}
		{/block}

    {if !$config->get('zipBeforeStreet')}
      {* Zip + City *}
      {block name='frontend_register_billing_fieldset_input_zip_and_city'}
        <div class="register--zip-city form-padding-bottom">
                  {if {config name=showZipBeforeCity}}
                      <input autocomplete="section-billing billing postal-code" name="register[billing][zipcode]" type="text" required="required" aria-required="true" placeholder="{s namespace='frontend/register/billing_fieldset' name='RegisterBillingPlaceholderZipcode'}{/s}{s name="RequiredField" namespace="frontend/register/index"}{/s}" id="zipcode" value="{$form_data.zipcode|escape}" class="register--field register--spacer register--field-zipcode is--required{if $error_flags.zipcode} has--error{/if}" />
                      <input autocomplete="section-billing billing address-level2" name="register[billing][city]" type="text" required="required" aria-required="true" placeholder="{s namespace='frontend/register/billing_fieldset' name='RegisterBillingPlaceholderCity'}{/s}{s name="RequiredField" namespace="frontend/register/index"}{/s}" id="city" value="{$form_data.city|escape}" size="25" class="register--field register--field-city is--required{if $error_flags.city} has--error{/if}" />
                  {else}
                      <input autocomplete="section-billing billing address-level2" name="register[billing][city]" type="text" required="required" aria-required="true" placeholder="{s namespace='frontend/register/billing_fieldset' name='RegisterBillingPlaceholderCity'}{/s}{s name="RequiredField" namespace="frontend/register/index"}{/s}" id="city" value="{$form_data.city|escape}" size="25" class="register--field register--spacer register--field-city is--required{if $error_flags.city} has--error{/if}" />
                      <input autocomplete="section-billing billing postal-code" name="register[billing][zipcode]" type="text" required="required" aria-required="true" placeholder="{s namespace='frontend/register/billing_fieldset' name='RegisterBillingPlaceholderZipcode'}{/s}{s name="RequiredField" namespace="frontend/register/index"}{/s}" id="zipcode" value="{$form_data.zipcode|escape}" class="register--field register--field-zipcode is--required{if $error_flags.zipcode} has--error{/if}" />
                  {/if}
        </div>
      {/block}
    {/if}

		{* Country *}
		{block name='frontend_register_billing_fieldset_input_country'}
			<div class="register--country field--select">
				<select name="register[billing][country]" id="country" required="required" aria-required="true" class="select--country is--required{if $error_flags.country} has--error{/if}">
                    {*<option disabled="disabled" value="" selected="selected">{s namespace='frontend/register/billing_fieldset' name='RegisterBillingPlaceholderCountry'}{/s}{s name="RequiredField" namespace="frontend/register/index"}{/s}</option>*}
                    {foreach $country_list as $country}
                        <option data-iso="{$country.countryiso}" value="{$country.id}" {if $country.id eq $form_data.countryID || $country.id eq $form_data.country}selected="selected"{/if} {if $country.states}stateSelector="country_{$country.id}_states"{/if}>
                            {$country.countryname}
                        </option>
                    {/foreach}
				</select>
			</div>
		{/block}

		{* Country state *}
		{block name='frontend_register_billing_fieldset_input_country_states'}
			<div class="country-area-state-selection">
				{foreach $country_list as $country}
					{if $country.states}
						<div id="country_{$country.id}_states" class="register--state-selection field--select{if $country.id != $form_data.countryID} is--hidden{/if}">
							<select {if $country.id != $form_data.countryID}disabled="disabled"{/if} name="register[billing][country_state_{$country.id}]"{if $country.force_state_in_registration} required="required" aria-required="true"{/if} class="select--state {if $country.force_state_in_registration}is--required{/if}{if $error_flags.stateID} has--error{/if}">
							    <option value="" selected="selected"{if $country.force_state_in_registration} disabled="disabled"{/if}>{s namespace='frontend/register/billing_fieldset' name='RegisterBillingLabelState'}{/s}{if $country.force_state_in_registration}{s name="RequiredField" namespace="frontend/register/index"}{/s}{/if}</option>
								{assign var="stateID" value="country_state_`$country.id`"}
								{foreach $country.states as $state}
									<option value="{$state.id}" {if $state.id eq $form_data[$stateID]}selected="selected"{/if}>
										{$state.name}
									</option>
								{/foreach}
							</select>
						</div>
					{/if}
				{/foreach}
			</div>
		{/block}

    {if !$isUpdate}
      {* Alternative *}
      {block name='frontend_register_billing_fieldset_different_shipping'}
        {if !$AdditionalShippingDisable}
          <div class="register--alt-shipping">
            <input name="register[billing][shippingAddress]" type="checkbox" id="register_billing_shippingAddress" value="1" {if $form_data.shippingAddress}checked="checked"{/if} />
            <label for="register_billing_shippingAddress">{s namespace='frontend/register/billing_fieldset' name='RegisterBillingLabelShipping'}{/s}</label>
          </div>
        {/if}
      {/block}
    {/if}
    {if $isUpdate}
      <a id="submit-billing-changes" class="btn is--small is--primary">
        {s name='OpcSendChanges'}Änderungen absenden{/s}
      </a>
    {/if}
	</div>
</div>