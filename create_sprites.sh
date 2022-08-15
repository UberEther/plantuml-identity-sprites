#!/usr/bin/env bash

# 
# (C) Copyright 2017, Anthony Gaudino
# (C) Copyright 2022, Matt Topper <matt@uberether.com> and UberEther contributors
# 
# The following script is derivative work of Anthony's sprite generator script found at:
# https://github.com/Piotr1215/sprites/blob/master/sprites/create_sprites.sh
# which is licensed via the GPL. This code therefore is also licensed under the terms
# of the GNU General Public License.
# 

#
# Batch creates sprite files for PlantUml
#
# Given a directory can convert all PNG files to PlantUml sprite files.
#
# The generated sprites files formats are based on the ones introduced in
# PlantUml 1.2017.19.
#
# This script assumes plantuml is in PATH.
#


# Help usage message
usage="Batch creates sprite files for PlantUml.

$(basename "$0") [options] prefix

options:
    -p  directory path to process  Default: ./
    -w  width  of PNG              Default: 48
    -h  height of PNG              Default: 48
    -g  sprite graylevel           Default: 16
    
    prefix: a prefix that is added to the sprite name"



# Default arguments values
        dir="./"  # Directory path to process     Default: ./
      width=48    # Width  of PNG to generate     Default: 48
     height=48    # Height of PNG to generate     Default: 48
  graylevel=16    # Number of grayscale colors    Default: 16

     prefix=""    # Prefix for sprites names, avoids having
prefixupper=""    # two sprites with same name on STDLIB



########################################
#
#    Main function
#
########################################
main () {
    # Get arguments
    while getopts p:w:h:g:s option
    do
        case "$option" in
            p)        dir="$OPTARG";;
            w)      width="$OPTARG";;
            h)     height="$OPTARG";;
            g)  graylevel="$OPTARG";;
            :) echo "$usage"
               exit 1
               ;;
           \?) echo "$usage"
               exit 1
               ;;
        esac
    done

    # Get mandatory argument
    shift $(($OPTIND-1))
    prefix=$(     echo $1 | tr '[:upper:]' '[:lower:]')
    prefixupper=$(echo $1 | tr '[:lower:]' '[:upper:]')

    # Check mandatory argument
    if [ -z "$prefix" ]
    then
        echo "Please specify a prefix!"
        echo "$usage"
        exit 1
    fi



    # Change dir to where images are
    if [ ! -d "${dir}" ]
    then
        echo "Please specify a valid directory"
        echo "$usage"
        exit 1
    fi
    
    cd "$dir"

    process_png
}


########################################
#
#    Generate PlantUml sprite
#
########################################
process_png () {
    for i in *.png
    do
        [ -f "$i" ] || continue
            mv "$i" "${i//-/_}"
    done

    for i in *.png
    do
        [ -f "$i" ] || continue

            filename=$(echo $i | sed -e 's/.png$//')                        # Filename without extension
            filenameupper=$(echo $filename | tr '[:lower:]' '[:upper:]')    # Filename without extension in uppercase
            spritename="${prefix}_$filename"                                # Sprite name is composed by prefix_filename
            spritenameupper="${prefixupper}_$filenameupper"                 # Sprite name in uppercase
            spritestereo="$prefixupper $filenameupper"                      # Sprite stereotype is uppercase prefix followed by uppercase filename
            stereowhites=$(echo $spritestereo | sed -e 's/./ /g')           # This is just whitespace to make output nicer

        #echo "@startuml" > $filename.puml

        echo -e "$(plantuml -encodesprite $graylevel $i | sed -e '1!b' -e 's/\$/$'${prefix}_'/')\n" > $filename.puml

        echo "!define $spritenameupper(_color)                                 SPRITE_PUT(          $stereowhites          $spritename, _color)"                 >> $filename.puml
        echo "!define $spritenameupper(_color, _scale)                         SPRITE_PUT(          $stereowhites          $spritename, _color, _scale)"         >> $filename.puml

        echo "!define $spritenameupper(_color, _scale, _alias)                 SPRITE_ENT(  _alias, $spritestereo,         $spritename, _color, _scale)"         >> $filename.puml
        echo "!define $spritenameupper(_color, _scale, _alias, _shape)         SPRITE_ENT(  _alias, $spritestereo,         $spritename, _color, _scale, _shape)" >> $filename.puml
        echo "!define $spritenameupper(_color, _scale, _alias, _shape, _label) SPRITE_ENT_L(_alias, $spritestereo, _label, $spritename, _color, _scale, _shape)" >> $filename.puml
        
        echo "skinparam folderBackgroundColor<<$prefixupper $filenameupper>> White"                                                                              >> $filename.puml
        
        #echo "@enduml" >> $filename.puml
    done
}


main "$@"