include $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/*/*.mk))
