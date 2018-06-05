<?php
namespace EffettoOnePageCheckout;
use Shopware\Components\Plugin;
use Shopware\Components\Plugin\Context\InstallContext;
use Shopware\Components\Plugin\Context\UninstallContext;
use Shopware\Components\Plugin\Context\UpdateContext;
class EffettoOnePageCheckout extends Plugin
{
    public function install(InstallContext $installContext)
    {
        return array(
            'success' => true,
            'invalidateCache' => array('config', 'backend', 'frontend')
        );
    }

    public function uninstall(UninstallContext $uninstallContext)
    {
        return array(
            'success' => true,
            'invalidateCache' => array('config', 'backend', 'frontend')
        );
    }

    public function update(UpdateContext $updateContext)
    {
        return array(
            'success' => true,
            'invalidateCache' => array('config', 'backend', 'frontend')
        );
    }
}