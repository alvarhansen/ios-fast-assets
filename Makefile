
project: install_xcodegen
	xcodegen --spec project.yml

fast: install_xcodegen
	xcodegen --spec fast.project.yml

install_xcodegen: .tools/xcodegen/bin/xcodegen

.tools/xcodegen/bin/xcodegen: scripts/install_xcodegen.sh
	scripts/install_xcodegen.sh
	touch $@