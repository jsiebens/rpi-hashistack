define build_image
	rm ${PWD}/dist/rpi-$1.iso || true
	rm -rf ${PWD}/output-arm-image
	docker run \
		--rm \
		--privileged \
		-v ${PWD}:/build:ro \
		-v ${PWD}/packer_cache:/build/packer_cache \
		-v ${PWD}/output-arm-image:/build/output-arm-image \
		registry.gitlab.com/nosceon/rpi-images/build-tools:build -var-file=/build/packer/variables.json "/build/packer/$1.json"
	mkdir -p ${PWD}/dist
	mv ${PWD}/output-arm-image/image ${PWD}/dist/rpi-$1.iso
	rm -rf ${PWD}/output-arm-image
endef

.PHONY: all
all: consul vault nomad nomad-client hashi-stack hashi-stack-ext

.PHONY: consul
consul:
	$(call build_image,consul)

.PHONY: vault
vault:
	$(call build_image,vault)

.PHONY: nomad
nomad:
	$(call build_image,nomad)

.PHONY: nomad-client
nomad-client:
	$(call build_image,nomad-client)

.PHONY: hashi-stack
hashi-stack:
	$(call build_image,hashi-stack)

.PHONY: hashi-stack-ext
hashi-stack-ext:
	$(call build_image,hashi-stack-ext)