bootstrap:
	@make install_xcodegen
	@make install_spmgen
	@make project
	@make workspace
	@make resources

remove_cli_tools:
	@chmod +x ./scripts/remove_cli_tools.sh
	@./scripts/remove_cli_tools.sh

install_spmgen:
	@chmod +x ./scripts/install_spmgen.sh
	@./scripts/install_spmgen.sh

install_xcodegen:
	@chmod +x ./scripts/install_xcodegen.sh
	@./scripts/install_xcodegen.sh

resources:
	@chmod +x ./scripts/generate_resources.sh
	@./scripts/generate_resources.sh

workspace:
	@chmod +x ./scripts/generate_xcworkspace.sh
	@./scripts/generate_xcworkspace.sh

project:
	@chmod +x ./scripts/generate_xcodeproj.sh
	@./scripts/generate_xcodeproj.sh
