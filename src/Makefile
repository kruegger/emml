include ../system/include.mk

include ../vsn.mk
VSN=$(EMML_VSN)

MODULES= emml_spec	\
	emml_gen	\
	emml_utils	\
	emml_frontend	\
	emml_fep_usage	\
	emml_fep_main	\
	emml_fep_success	\
	emml_fep_error	\
	emml_fep_init	\
	emml_fep_params	\
	emml_fep_name	\
	emml_fep_audit	\
	emml_fep_remote_node	\
	emml_fep_out	\
	emml_fep_cookie \
	emml_fep_call	\
	emml_backend	\
	emml_bep_comment	\
	emml_bep_header	\
	emml_bep_main	\
	emml_bep_usage	\
	emml_bep_internal

EBIN_FILES=$(MODULES:%=../ebin/%.$(EMULATOR)) ../ebin/emml.app
ERLC_FLAGS+=-I../include -I. -I../..

#
# Targets
#

all: $(EBIN_FILES) 

debug:
	$(MAKE) ERLC_FLAGS+="$(ERLC_FLAGS) +debug_info -Ddebug"

clean:
	rm -f $(EBIN_FILES)
