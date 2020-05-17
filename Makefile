define build_image
	rm ${PWD}/output-arm-image/$1.iso || true
	docker run \
		--rm \
		--privileged \
		-v ${PWD}:/build:ro \
		-v ${PWD}/packer_cache:/build/packer_cache \
		-v ${PWD}/output-arm-image:/build/output-arm-image \
		registry.gitlab.com/nosceon/rpi-images/build-tools:build "/build/packer/$1.json"

	mv ${PWD}/output-arm-image/image ${PWD}/output-arm-image/$1.iso
endef

.PHONY: all
all: consul

.PHONY: consul
consul:
	$(call build_image,consul)