###############################################################################
# (C) Copyright ----
# -----
# All rights reserved.
#
# Purpose:
#  WOLFSSL / WOLFMQTT + lwIP networking personality option make rules
#
# $Id: wolfmqtt.mk,v 1.1 2020/04/24 12:11:45 gup Exp $
# $Author: ---- $
# $Date: ---- $
# $Revision: ---- $
###############################################################################

ifneq ($(MAKEINC_OPTION_POSIX_WOLFMQTT_MK),included)
MAKEINC_OPTION_POSIX_WOLFMQTT_MK := included

ifeq ($(POSIX_WOLFMQTT), true)

# Add personality option identifier
	CPPFLAGS += -DPOSIX_WOLFMQTT

# If $(POSIX_WOLFMQTT_CUSTOM) is set, we do not refer to lwIP bits
# from the custom pool. This is for compatibility with older
# versions and will be removed in future versions.
ifeq ($(POSIX_WOLFMQTT_CUSTOM), true)
# If unset in the configuration, default custom lwIP files to current directory
	POSIX_WOLFMQTT_LIB_DIR ?= .
# Add lwIP custom configuration header
	CPPFLAGS += -I$(POSIX_WOLFMQTT_LIB_DIR)
# Add lwIP custom library path
	LDFLAGS += -L$(POSIX_WOLFMQTT_LIB_DIR)

$(eval $(call declare_variable,POSIX_WOLFMQTT_LIB_DIR,Path to the customized lwIP library))

else
# Add lwIP standard configuration header
	CPPFLAGS += -I$(PIKEOS_POOL_DIR)/posix/wolfmqtt/include
# Add lwIP library path
	LDFLAGS += -L$(CUSTOM_POOL_DIR)/posix/wolfmqtt/lib

# Add lwIP headers
	CPPFLAGS += -I$(CUSTOM_POOL_DIR)/posix/wolfmqtt/include
endif

# Add lwIP library
	LDLIBS += -lwolfmqtt

endif

endif
