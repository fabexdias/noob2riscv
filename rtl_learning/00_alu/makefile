TOP = tb_alu

RTL = rtl/alu.sv
TB  = tb/tb_alu.sv

BUILD_DIR = build

VERILATOR = verilator

.PHONY: all sim lint wave clean

all: wave

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

lint: $(BUILD_DIR)
	$(VERILATOR) --lint-only \
		-Wall \
		--top-module $(TOP) \
		$(RTL) $(TB)

sim: $(BUILD_DIR)
	$(VERILATOR) \
		--binary \
		--trace \
		--trace-fst \
		-Wall \
		--top-module $(TOP) \
		-Mdir $(BUILD_DIR) \
		$(RTL) $(TB)

	$(BUILD_DIR)/V$(TOP)

wave: sim
	gtkwave $(BUILD_DIR)/$(TOP).fst

clean:
	rm -rf $(BUILD_DIR)