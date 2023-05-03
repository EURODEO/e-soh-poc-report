#!/bin/bash

set -ve

GIT_REPO_NAME="e-soh-poc-report"
GIT_REPO_URL=${GIT_REPO_URL:-https://github.com/EURODEO/e-soh-poc-report}

VERSION=${VERSION:-main}

# For local testing, use this:
#VERSION=<issue-branch>

IMAGES_DIR=${IMAGES_DIR:-source/images}
PDF_THEMES_DIR=${PDF_THEMES_DIR:-source}
HTML_DIR=${HTML_DIR:-html}
PDF_DIR=${PDF_DIR:-pdf}

#CWD=$(pwd)
##the following line solves "fatal: detected dubious ownership in 
## repository at '/workdir/data-management-handbook'":
##git config --global --add safe.directory '*'
#if [ -d "${DMH_FOLDER_GENERAL}" ]; then
#  echo "$DMH_FOLDER_GENERAL repository exists locally, running git pull"
#  cd $DMH_FOLDER_GENERAL
#  git pull
#else
#  echo "Cloning $DMH_GENERAL"
#  git clone $DMH_GENERAL
#  cd $DMH_FOLDER_GENERAL
#  git checkout $DMH_GENERAL_VERSION
#fi
#GENERAL_DMH_DIR=$(pwd)
#
#cd $CWD
#
#cp $DMH_FOLDER_GENERAL/source/images/*.png $IMAGES_DIR

asciidoctor -r asciidoctor-diagram \
      -a toc=left \
      -a imagesdir=$IMAGES_DIR \
      -a data-uri=Yes \
      -n source/proof-of-concept-report.adoc \
      -D $HTML_DIR
  
#asciidoctor-pdf -r asciidoctor-diagram \
#      -a pdf-themesdir=$PDF_THEMES_DIR \
#      -a pdf-theme=dmh \
#      -a title_page=$TITLE_PAGE \
#      -a special_intro=$SPECIAL_INTRO \
#      -a special_strudoc=$SPECIAL_STRUDOC \
#      -a special_data_services=$SPECIAL_DATA_SERVICES \
#      -a special_user_portals=$SPECIAL_USER_PORTALS \
#      -a special_data_governance=$SPECIAL_DATA_GOVERNANCE \
#      -a special_practical_guidance=$SPECIAL_PRACTICAL_GUIDANCE \
#      -a special_nc2thredds=$SPECIAL_NC2THREDDS \
#      -a spec_default_global_attrs=$SPEC_DEFAULT_GLOBAL_ATTRS \
#      -a special_appendix_users=$SPECIAL_APPENDIX_USERS \
#      -a imagesdir=$IMAGES_DIR \
#      -n $DMH_FOLDER_GENERAL/source/data-management-handbook.adoc \
#      -D $RESULTS_PDF
#cd ..
