default:
	packer build template.json

.PHONY: vmware-iso
vmware-iso:
	packer build -only=vmware-iso template.json

.PHONY: virtualbox-iso
virtualbox-iso:
	packer build -only=virtualbox-iso template.json

.PHONY: help
help:
	@echo "Perform a Packer build"
	@echo "Targets:"
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs

.PHONY: clean
clean:
	rm -rf output-*
	rm *.box
