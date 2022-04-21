cd Playgrounds/ScriptNode.swiftpm
ls -1 | egrep -v "^(Assets.xcassets|Package.swift)$" # | xargs rm -r
ls -1 | egrep -v "^(Assets.xcassets|Package.swift)$" | xargs rm -r
rsync -av --exclude='Assets.xcassets' --exclude='NodeEditor.entitlements' --exclude='Preview Content' ../../NodeEditor/ ./
cd ../..