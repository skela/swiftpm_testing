all: build run

build:
	swift build

run:
	.build/debug/Testing
