
archive

xcodebuild -sdk iphonesimulator -configuration Release

cp -R  ./build/Release-iphonesimulator/LatipaySDK_Swift.framework/Modules/LatipaySDK_Swift.swiftmodule

lipo -create -output  outfile infile1 infile2 
