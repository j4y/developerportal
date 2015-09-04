jekyll serve --config config_base.yml,config_designer.yml,config_designer_pdf.yml&
sleep 9

prince --input-list=../developerportal/designer-pdf/prince-file-list.txt -o ../developerportal/pdf-output/designer.pdf

kill -9 $(ps aux | grep '[j]ekyll' | awk '{print $2}')