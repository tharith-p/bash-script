#!/bin/bash
#run me like below
# ./client-bundle.sh

echo -e "\e[92mStarting >>>>>>>>>>>>>>>>>>>>>>>>>"
RootPath=./page/assets/
PagePath="$RootPath"module
AppJs="$RootPath"app.js
AppJsBase="$RootPath"app.base.js
AppCss="$RootPath"app.css
AppCssBase="$RootPath"app.base.css
AppJsDirPatterns=($PagePath/[0-9]_*/js/[0-9]_*.js $PagePath/[0-9]_*/js/[0-9][0-9]_*.js $PagePath/[0-9][0-9]_*/js/[0-9]_*.js $PagePath/[0-9][0-9]_*/js/[0-9][0-9]_*.js)
AppCssDirPatterns=($PagePath/[0-9]_*/css/[0-9]_*.css $PagePath/[0-9]_*/css/[0-9][0-9]_*.css $PagePath/[0-9][0-9]_*/css/[0-9]_*.css $PagePath/[0-9][0-9]_*/css/[0-9][0-9]_*.css)

#remove
rm $AppJs $AppJsBase $AppCss $AppCssBase

echo -e "\e[93mCombining JS ..."
if [ ! -e $AppJsBase ]; then
	touch $AppJsBase
fi

if [ ! -e $AppJs ]; then
        touch $AppJs
fi

# js files
for FileJs in ${AppJsDirPatterns[@]}
do
	if [ -f "$FileJs" ]; then
		# title as file name
		#echo "// $FileJs" >> $AppJsBase;
		echo ">: $FileJs";
		# merge js
		cat $FileJs >> $AppJsBase;
	fi
done

# compress
terser $AppJsBase -o $AppJs
rm $AppJsBase
#echo -e "\e[42m Next task ..."


echo -e "\e[93mCombining CSS ..."
if [ ! -e $AppCss ]; then
	touch $AppCss
fi

if [ ! -e $AppCssBase ]; then
	touch $AppCssBase
fi

# js files
#for FileCss in $RootPath[0-9]_*.css $RootPath[0-9][0-9]_*.css
for FileCss in ${AppCssDirPatterns[@]}
do
	if [ -f "$FileCss" ]; then
        # title as file name
        #echo "/* $FileCss */" >> $AppCssBase;
		echo ">: $FileCss";
        # merge css
        cat $FileCss >> $AppCssBase;
	fi
done

# compress
uglifycss $AppCssBase > $AppCss
rm $AppCssBase
# done block
echo -e "\e[92mDone <<<<<<<<<<<<<<<<<<<<<<<<<<<<< \e[0m"
