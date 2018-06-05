{block name='frontend_checkout_confirm_information_addresses'}

  {if $activeBillingAddressId == $activeShippingAddressId}

    {* Equal Billing & Shipping *}
    {block name='frontend_checkout_confirm_information_addresses_equal'}
      <div class="information--panel-item information--panel-address">

      {block name='frontend_checkout_confirm_information_addresses_equal_panel'}
        <div class="panel  is--rounded block information--panel">

        {block name='frontend_checkout_confirm_information_addresses_equal_panel_title'}
          <div class="panel--title is--underline">
            {s namespace="frontend/checkout/confirm" name='ConfirmAddressEqualTitle'}{/s}
          </div>
        {/block}

        {block name='frontend_checkout_confirm_information_addresses_equal_panel_body'}
          <div class="panel--body is--wide">

          {block name='frontend_checkout_confirm_information_addresses_equal_panel_billing'}
            <div class="billing--panel">
            {if $sUserData.billingaddress.company}
              <span class="address--company is--bold">{$sUserData.billingaddress.company}</span>{if $sUserData.billingaddress.department}<br /><span class="address--department is--bold">{$sUserData.billingaddress.department}</span>{/if}
              <br />
            {/if}

            <span class="address--salutation">{$sUserData.billingaddress.salutation|salutation}</span>
            {if {config name="displayprofiletitle"}}
              <span class="address--title">{$sUserData.billingaddress.title}</span><br/>
            {/if}
            <span class="address--firstname">{$sUserData.billingaddress.firstname}</span> <span class="address--lastname">{$sUserData.billingaddress.lastname}</span><br/>
            <span class="address--street">{$sUserData.billingaddress.street}</span><br />
            {if $sUserData.billingaddress.additional_address_line1}<span class="address--additional-one">{$sUserData.billingaddress.additional_address_line1}</span><br />{/if}
            {if $sUserData.billingaddress.additional_address_line2}<span class="address--additional-two">{$sUserData.billingaddress.additional_address_line2}</span><br />{/if}
          {if {config name=showZipBeforeCity}}
            <span class="address--zipcode">{$sUserData.billingaddress.zipcode}</span> <span class="address--city">{$sUserData.billingaddress.city}</span>
            {else}
            <span class="address--city">{$sUserData.billingaddress.city}</span> <span class="address--zipcode">{$sUserData.billingaddress.zipcode}</span>
          {/if}<br />
            {if $sUserData.additional.state.name}<span class="address--statename">{$sUserData.additional.state.name}</span><br />{/if}
            <span class="address--countryname">{$sUserData.additional.country.countryname}</span>

            {block name="frontend_checkout_confirm_information_addresses_equal_panel_billing_invalid_data"}
              {if $invalidBillingAddress}
                {include file='frontend/_includes/messages.tpl' type="warning" content="{s namespace="frontend/checkout/confirm" name='ConfirmAddressInvalidAddress'}{/s}"}
              {else}
                                                                    {block name="frontend_checkout_confirm_information_addresses_equal_panel_billing_set_as_default"}
                                                                    {/block}
                                                                {/if}
                                                            {/block}
                                                        </div>
                                                    {/block}

                                                    {block name='frontend_checkout_confirm_information_addresses_equal_panel_shipping'}
                                                        <div class="shipping--panel">
                                                            {block name='frontend_checkout_confirm_information_addresses_equal_panel_shipping_select_address'}
                                                                {*
                                                            <a href="{url controller=address}"
                                                                   class="btn choose-different-address"
                                                                   data-address-selection="true"
                                                                   data-sessionKey="checkoutShippingAddressId"
                                                                    data-setDefaultShippingAddress="true"
                                                                   data-id="{$activeShippingAddressId}"
                                                                   title="{s namespace="frontend/checkout/confirm" name="ConfirmAddressChooseDifferentShippingAddress"}{/s}">
                                                                    {s namespace="frontend/checkout/confirm" name="ConfirmAddressChooseDifferentShippingAddress"}{/s}
        </a>*}
        {/block}
        </div>
        {/block}
        </div>

          {block name='frontend_checkout_confirm_information_addresses_equal_panel_actions'}
          <div class="is--wide">
            {block name="frontend_checkout_confirm_information_addresses_equal_panel_actions_change"}
            <div class="address--actions-change">
              {block name='frontend_checkout_confirm_information_addresses_equal_panel_shipping_change_address'}
              <a href="{url controller=address action=edit id=$activeBillingAddressId sTarget=checkout sTargetAction=confirm}"
                                                                       data-address-editor="true"
                                                                       data-setDefaultBillingAddress="true"
                                                                       data-id="{$activeBillingAddressId}"
                                                                       data-sessionKey="checkoutBillingAddressId,checkoutShippingAddressId"
                                                                       data-title="{s namespace="frontend/checkout/confirm" name="ConfirmAddressSelectButton"}Change address{/s}"
                                                                       title="{s namespace="frontend/checkout/confirm" name="ConfirmAddressSelectButton"}Change address{/s}"
                                                                       class="btn">
                                                                        {s namespace="frontend/checkout/confirm" name="ConfirmAddressSelectButton"}Change address{/s}
              </a>
              {/block}

              {block name='frontend_checkout_confirm_information_addresses_equal_panel_shipping_select_address'}
                {if !$AdditionalShippingDisable}
                  <a href="{url controller=address}"
                                                                       class="btn choose-different-address"
                                                                       data-address-selection="true"
                                                                       data-sessionKey="checkoutShippingAddressId"
                                                                       data-setDefaultShippingAddress="true"
                                                                       data-id="{$activeShippingAddressId}"
                                                                       title="{s namespace="frontend/checkout/confirm" name="ConfirmAddressChooseDifferentShippingAddress"}{/s}">
                                                                        {s namespace="frontend/checkout/confirm" name="ConfirmAddressChooseDifferentShippingAddress"}{/s}
                  </a>
                {/if}
              {/block}
            </div>
            {/block}
            {block name="frontend_checkout_confirm_information_addresses_equal_panel_actions_select_address"}
            <a href="{url controller=address}"
                                                               title="{s namespace="frontend/checkout/confirm" name="ConfirmAddressSelectLink"}{/s}"
                                                               data-address-selection="true"
                                                               data-sessionKey="checkoutBillingAddressId,checkoutShippingAddressId"
                                                               data-setDefaultBillingAddress="true"
                                                               data-id="{$activeBillingAddressId}">
                                                                {s namespace="frontend/checkout/confirm" name="ConfirmAddressSelectLink"}{/s}
            </a>
            {/block}
          </div>
          {/block}
        {/block}
      </div>
      {/block}
    </div>
    {/block}
    <input type="hidden" name="setAsDefaultAddress" id="set_as_default" value="1" />
  {else}

    {* Separate Billing & Shipping *}
    {block name='frontend_checkout_confirm_information_addresses_billing'}
    <div class="information--panel-item information--panel-item-billing">
      {* Billing address *}
      {block name='frontend_checkout_confirm_information_addresses_billing_panel'}
      <div class="panel  block information--panel billing--panel">

        {* Headline *}
        {block name='frontend_checkout_confirm_information_addresses_billing_panel_title'}
        <div class="panel--title is--underline">
          {s name="ConfirmHeaderBilling" namespace="frontend/checkout/confirm"}{/s}
        </div>
        {/block}

        {* Content *}
        {block name='frontend_checkout_confirm_information_addresses_billing_panel_body'}
        <div class="panel--body is--wide">
          {if $sUserData.billingaddress.company}
          <span class="address--company is--bold">{$sUserData.billingaddress.company}</span>{if $sUserData.billingaddress.department}<br /><span class="address--department is--bold">{$sUserData.billingaddress.department}</span>{/if}
          <br />
          {/if}
        <span class="address--salutation">{$sUserData.billingaddress.salutation|salutation}</span>
          {if {config name="displayprofiletitle"}}
          <span class="address--title">{$sUserData.billingaddress.title}</span><br/>
          {/if}
        <span class="address--firstname">{$sUserData.billingaddress.firstname}</span> <span class="address--lastname">{$sUserData.billingaddress.lastname}</span><br />
        <span class="address--street">{$sUserData.billingaddress.street}</span><br />
          {if $sUserData.billingaddress.additional_address_line1}<span class="address--additional-one">{$sUserData.billingaddress.additional_address_line1}</span><br />{/if}
          {if $sUserData.billingaddress.additional_address_line2}<span class="address--additional-two">{$sUserData.billingaddress.additional_address_line2}</span><br />{/if}
          {if {config name=showZipBeforeCity}}
          <span class="address--zipcode">{$sUserData.billingaddress.zipcode}</span> <span class="address--city">{$sUserData.billingaddress.city}</span>
          {else}
          <span class="address--city">{$sUserData.billingaddress.city}</span> <span class="address--zipcode">{$sUserData.billingaddress.zipcode}</span>
          {/if}<br />
          {if $sUserData.additional.state.name}<span class="address--statename">{$sUserData.additional.state.name}</span><br />{/if}
        <span class="address--countryname">{$sUserData.additional.country.countryname}</span>

          {block name="frontend_checkout_confirm_information_addresses_billing_panel_body_invalid_data"}
            {if $invalidBillingAddress}
              {include file='frontend/_includes/messages.tpl' type="warning" content="{s namespace="frontend/checkout/confirm" name='ConfirmAddressInvalidBillingAddress'}{/s}"}
                                                        {else}
                                                            {block name="frontend_checkout_confirm_information_addresses_billing_panel_body_set_as_default"}
                                                            {/block}
                                                        {/if}
                                                    {/block}
                                                </div>
                                            {/block}

                                            {* Action buttons *}
                                            {block name="frontend_checkout_confirm_information_addresses_billing_panel_actions"}
                                                <div class="is--wide">
                                                    {block name="frontend_checkout_confirm_information_addresses_billing_panel_actions_change"}
                                                        <div class="address--actions-change">
                                                            {block name="frontend_checkout_confirm_information_addresses_billing_panel_actions_change_address"}
                                                            <input type="hidden" name="setAsDefaultBillingAddress" id="set_as_default_billing" value="1" />
                                                            <a href="{url controller=address action=edit id=$activeBillingAddressId sTarget=checkout sTargetAction=confirm}"
                                                                   data-address-editor="true"
                                                                   data-sessionKey="checkoutBillingAddressId"
                                                                   data-setDefaultBillingAddress="true"
                                                                   data-id="{$activeBillingAddressId}"
                                                                   data-title="{s namespace="frontend/checkout/confirm" name="ConfirmAddressSelectButton"}Change address{/s}"
                                                                   title="{s namespace="frontend/checkout/confirm" name="ConfirmAddressSelectButton"}Change address{/s}"
                                                                   class="btn">
                                                                    {s namespace="frontend/checkout/confirm" name="ConfirmAddressSelectButton"}Change address{/s}
      </a>
      {/block}
      </div>
      {/block}
        {block name="frontend_checkout_confirm_information_addresses_billing_panel_actions_select_address"}
        <a href="{url controller=address}"
                                                           data-address-selection="true"
                                                           data-sessionKey="checkoutBillingAddressId"
                                                           data-setDefaultBillingAddress="true"
                                                           data-id="{$activeBillingAddressId}"
                                                           title="{s namespace="frontend/checkout/confirm" name="ConfirmAddressSelectLink"}{/s}">
                                                            {s namespace="frontend/checkout/confirm" name="ConfirmAddressSelectLink"}{/s}
        </a>
        {/block}
      </div>
      {/block}
      </div>
      {/block}
    </div>
    {/block}

    {block name='frontend_checkout_confirm_information_addresses_shipping'}
    <div class="information--panel-item information--panel-item-shipping">
      {block name='frontend_checkout_confirm_information_addresses_shipping_panel'}
      <div class="panel  block information--panel shipping--panel">

        {* Headline *}
        {block name='frontend_checkout_confirm_information_addresses_shipping_panel_title'}
        <div class="panel--title is--underline">
          {s name="ConfirmHeaderShipping" namespace="frontend/checkout/confirm"}{/s}
        </div>
        {/block}

        {* Content *}
        {block name='frontend_checkout_confirm_information_addresses_shipping_panel_body'}
        <div class="panel--body is--wide">
          {if $sUserData.shippingaddress.company}
          <span class="address--company is--bold">{$sUserData.shippingaddress.company}</span>{if $sUserData.shippingaddress.department}<br /><span class="address--department is--bold">{$sUserData.shippingaddress.department}</span>{/if}
          <br />
          {/if}

        <span class="address--salutation">{$sUserData.shippingaddress.salutation|salutation}</span>
          {if {config name="displayprofiletitle"}}
          <span class="address--title">{$sUserData.shippingaddress.title}</span><br/>
          {/if}
        <span class="address--firstname">{$sUserData.shippingaddress.firstname}</span> <span class="address--lastname">{$sUserData.shippingaddress.lastname}</span><br/>
        <span class="address--street">{$sUserData.shippingaddress.street}</span><br />
          {if $sUserData.shippingaddress.additional_address_line1}<span class="address--additional-one">{$sUserData.shippingaddress.additional_address_line1}</span><br />{/if}
          {if $sUserData.shippingaddress.additional_address_line2}<span class="address--additional-one">{$sUserData.shippingaddress.additional_address_line2}</span><br />{/if}
          {if {config name=showZipBeforeCity}}
          <span class="address--zipcode">{$sUserData.shippingaddress.zipcode}</span> <span class="address--city">{$sUserData.shippingaddress.city}</span>
          {else}
          <span class="address--city">{$sUserData.shippingaddress.city}</span> <span class="address--zipcode">{$sUserData.shippingaddress.zipcode}</span>
          {/if}<br />
          {if $sUserData.additional.stateShipping.name}<span class="address--statename">{$sUserData.additional.stateShipping.name}</span><br />{/if}
        <span class="address--countryname">{$sUserData.additional.countryShipping.countryname}</span>

          {block name="frontend_checkout_confirm_information_addresses_shipping_panel_body_invalid_data"}
            {if $invalidShippingAddress}
              {include file='frontend/_includes/messages.tpl' type="warning" content="{s namespace="frontend/checkout/confirm" name='ConfirmAddressInvalidShippingAddress'}{/s}"}
                                                        {else}
                                                            {block name="frontend_checkout_confirm_information_addresses_shipping_panel_body_set_as_default"}
                                                            {/block}
                                                        {/if}
                                                    {/block}
                                                </div>
                                            {/block}

                                            {* Action buttons *}
                                            {block name="frontend_checkout_confirm_information_addresses_shipping_panel_actions"}
                                                <div class="is--wide">
                                                    {block name="frontend_checkout_confirm_information_addresses_shipping_panel_actions_change"}
                                                        <div class="address--actions-change">
                                                            {block name="frontend_checkout_confirm_information_addresses_shipping_panel_actions_change_address"}
                                                              <input type="hidden" name="setAsDefaultShippingAddress" id="set_as_default_shipping" value="1" />
                                                              {if !$AdditionalShippingDisable}
                                                                <a href="{url controller=address action=edit id=$activeShippingAddressId sTarget=checkout sTargetAction=confirm}"
                                                                     title="{s namespace="frontend/checkout/confirm" name="ConfirmAddressSelectButton"}Change address{/s}"
                                                                     data-title="{s namespace="frontend/checkout/confirm" name="ConfirmAddressSelectButton"}Change address{/s}"
                                                                     data-address-editor="true"
                                                                     data-setDefaultShippingAddress="true"
                                                                     data-id="{$activeShippingAddressId}"
                                                                     data-sessionKey="checkoutShippingAddressId"
                                                                     class="btn">
                                                                      {s namespace="frontend/checkout/confirm" name="ConfirmAddressSelectButton"}Change address{/s}
                                                                </a>
                                                              {/if}
      {/block}
      </div>
      {/block}
        {block name="frontend_checkout_confirm_information_addresses_shipping_panel_actions_select_address"}
          {if !$AdditionalShippingDisable}
            <a href="{url controller=address}"
                                                           data-address-selection="true"
                                                           data-sessionKey="checkoutShippingAddressId"
                                                           data-setDefaultShippingAddress="true"
                                                           data-id="{$activeShippingAddressId}"
                                                           title="{s namespace="frontend/checkout/confirm" name="ConfirmAddressSelectLink"}{/s}">
                                                            {s namespace="frontend/checkout/confirm" name="ConfirmAddressSelectLink"}{/s}
            </a>
          {/if}
        {/block}
      </div>
      {/block}
      </div>
      {/block}
    </div>
    {/block}
  {/if}
{/block}