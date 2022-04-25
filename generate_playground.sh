cd Playgrounds/Pegboard.swiftpm/App
ls -1 | egrep -v "^(Package.swift)$" # | xargs rm -r
ls -1 | egrep -v "^(Package.swift)$" | xargs rm -r
rsync -av --exclude='NodeEditor.entitlements' --exclude='Preview Content' ../../../NodeEditor/ ./
cd ../../..