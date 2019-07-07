echo "running script to install darktable on fedora"

starttime=$(date +%s)

arr_libraries=(cmake gcc-c++ intltool gtk3-devel libxml2-devel lensfun-devel librsvg2-devel sqlite-devel 
libcurl-devel libjpeg-turbo-devel libtiff-devel lcms2-devel json-glib-devel exiv2-devel pugixml-devel libxslt 
libgphoto2-devel OpenEXR-devel libwebp-devel flickcurl-devel openjpeg-devel openjpeg2-devel libsecret-devel 
GraphicsMagick-devel osm-gps-map-devel colord-devel colord-gtk-devel cups-devel python3-jsonschema)

arr_install_libraries=()

echo ${#arr_libraries[@]}
echo ${#arr_install_libraries[@]}

i=0

while [ $i -lt ${#arr_libraries[@]} ]
    do
        number=$(rpm -qa ${arr_libraries[$i]} | wc -c )
        if [ $number -gt 0 ];
        then
            echo -e "[\xE2\x9C\x94] ${arr_libraries[$i]} existing"
        else
            echo -e "[\xE2\x9D\x8C] ${arr_libraries[$i]} missing"
            arr_install_libraries+=(${arr_libraries[$i]})       
       fi
        i=$((i+1))
    done

libs=$(IFS=$' '; echo "${arr_install_libraries[*]}")

if [ ${#arr_install_libraries[@]} -gt 0 ];
  then
    sudo dnf install $libs
fi

git clone "git://github.com/darktable-org/darktable.git"

cd darktable

git pull

mkdir build

cd build

cmake -DCMAKE_BUILD_TYPE=Release ..

make -j5

make install