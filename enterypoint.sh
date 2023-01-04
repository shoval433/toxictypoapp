
if [ $# -eq 0 ]
then
  size=150
else
  size=$1
fi
export TN_SIZE=$size
image_dir="/pic"

for image in "$image_dir"/*
do
  ./thumbnail.sh "$image" 
done
