<form name="sLogin" class="register--login" method="post" action="{url action=login controller=EffettoOnePageCheckout}">
  <h2 class="panel--title is--underline {if !$registerData && $config->get('loginInitiallyOpen')}is--active{/if}" id="opc-login-link" data-collapsetarget="#opc-login" href="#opc-login" data-closeSiblings="true">{s namespace="frontend/account/login" name="LoginHeaderExistingCustomer"}{/s}</h2>

  {include file="frontend/register/error_message.tpl" error_messages=$loginDataError}

  <div class="panel--body is--wide {if !$registerData && $config->get('loginInitiallyOpen')}is--collapsed{/if}" id="opc-login">
    <p>{s namespace="frontend/account/login" name="LoginHeaderFields"}{/s}</p>
    <div class="register--login-email form-padding-bottom">
      <input name="email" placeholder="{s namespace="frontend/account/login" name="LoginPlaceholderMail"}{/s}" type="email" tabindex="1" value="{$sFormDataLogin.email|escape}" id="email" class="register--login-field{if $sErrorFlag.email} has--error{/if}" />
    </div>

    <div class="register--login-password form-padding-bottom">
      <input name="password" placeholder="{s namespace="frontend/account/login" name="LoginPlaceholderPassword"}{/s}" type="password" tabindex="2" id="passwort" class="register--login-field{if $sErrorFlag.password} has--error{/if}" />
    </div>

    <div class="register--login-lostpassword form-padding-bottom">
      <a href="{url controller=account action=password}" title="{"{s name="LoginLinkLostPassword"}{/s}"|escape}">
        {s namespace="frontend/account/login" name="LoginLinkLostPassword"}{/s}
      </a>
    </div>

    <div class="action">
      <button class="register--login-btn btn is--primary is--large is--icon-right" type="submit" name="Submit">{s namespace="frontend/account/login" name='LoginLinkLogon'}{/s}<i class="icon--arrow-right"></i></button>
    </div>
  </div>
</form>
