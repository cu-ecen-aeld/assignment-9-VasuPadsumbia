
##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
LDD_VERSION = 29c318de3d108f107c5aa222e5ed9b1b3cf97289
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
LDD_SITE = git@github.com:cu-ecen-aeld/assignment-7-VasuPadsumbia.git
LDD_SITE_METHOD = git
LDD_GIT_SUBMODULES = YES

define LDD_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/misc-modules KERNELDIR=$(LINUX_DIR) ARCH=arm64 CROSS_COMPILE=$(TARGET_CROSS) modules
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/misc-modules KERNELDIR=$(LINUX_DIR) ARCH=arm64 CROSS_COMPILE=$(TARGET_CROSS) INSTALL_MOD_PATH=$(TARGET_DIR) modules_install 
    
	$(HOST_DIR)/sbin/depmod -b $(TARGET_DIR) $(LINUX_VERSION_PROBED)

	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/scull KERNELDIR=$(LINUX_DIR) ARCH=arm64 CROSS_COMPILE=$(TARGET_CROSS) modules
	
endef

# TODO add your writer, finder and finder-test utilities/scripts to the installation steps below
define LDD_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/etc/modules/misc-modules
	mkdir -p $(TARGET_DIR)/etc/modules/scull
	$(INSTALL) -d 0755 $(@D)/misc-modules
	for f in $(@D)/misc-modules/*; do \
	    $(INSTALL) -m 0755 $$f $(TARGET_DIR)/etc/modules/misc-modules/; \
	done
	$(INSTALL) -d 0755 $(@D)/scull
	for f in $(@D)/scull/*; do \
	    $(INSTALL) -m 0755 $$f $(TARGET_DIR)/etc/modules/scull/; \
	done
endef

$(eval $(generic-package))
