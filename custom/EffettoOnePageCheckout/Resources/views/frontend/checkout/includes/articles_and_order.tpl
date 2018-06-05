{block name='frontend_checkout_confirm_product_table'}
  <div class="product--table">
    <div class="panel has--border">
      {* Basket items *}
      {block name='frontend_checkout_confirm_item_outer'}
        {foreach $sBasket.content as $sBasketItem}
          {block name='frontend_checkout_confirm_item'}
            {include file='frontend/checkout/includes/confirm_item.tpl' isLast=$sBasketItem@last}
          {/block}
        {/foreach}
      {/block}

      {block name='frontend_checkout_confirm_item_after'}{/block}

      {include file='frontend/checkout/includes/additional_features.tpl'}

      {* Table footer *}
      {block name='frontend_checkout_confirm_confirm_footer'}
        {include file="frontend/checkout/confirm_footer.tpl"}
      {/block}

      {if !$config->get('AgbOnTop')}
        {include file='frontend/checkout/includes/agb_and_revocation.tpl'}
      {else}
        <br />
      {/if}
    </div>

    {* Table actions *}
    {block name='frontend_checkout_confirm_confirm_table_actions'}
      <div class="table--actions actions--bottom">
        <div class="main--actions">
          {if !$sLaststock.hideBasket}

            {block name='frontend_checkout_confirm_submit'}
              {* Submit order button *}
              {if $sPayment.embediframe || $sPayment.action}
                <button type="submit" class="btn is--primary is--large right is--icon-right" form="confirm--form" data-preloader-button="true">
                  {s namespace='frontend/checkout/confirm' name='ConfirmDoPayment'}{/s}<i class="icon--arrow-right"></i>
                </button>
              {else}
                <button type="submit" class="btn is--primary is--large right is--icon-right" form="confirm--form" data-preloader-button="true">
                  {s namespace='frontend/checkout/confirm' name='ConfirmActionSubmit'}{/s}<i class="icon--arrow-right"></i>
                </button>
              {/if}
            {/block}
          {else}
            {block name='frontend_checkout_confirm_stockinfo'}
              {include file="frontend/_includes/messages.tpl" type="error" content="{s namespace='frontend/checkout/confirm' name='ConfirmErrorStock'}{/s}"}
            {/block}
          {/if}
        </div>
      </div>
    {/block}
  </div>
{/block}

