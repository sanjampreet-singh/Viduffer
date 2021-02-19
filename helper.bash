ffmpeg -i input.mp4 -s 160x90 -c:v libx264 -b:v 250k -g 90 -an input_video_160x90_250k.mp4
ffmpeg -i input.mp4 -s 320x180 -c:v libx264 -b:v 500k -g 90 -an input_video_320x180_500k.mp4
ffmpeg -i input.mp4 -s 640x360 -c:v libx264 -b:v 750k -g 90 -an input_video_640x360_750k.mp4
ffmpeg -i input.mp4 -s 640x360 -c:v libx264 -b:v 1000k -g 90 -an input_video_640x360_1000k.mp4
ffmpeg -i input.mp4 -s 1280x720 -c:v libx264 -b:v 1500k -g 90 -an input_video_1280x720_1500k.mp4
ffmpeg -i input.mp4 -c:a aac -b:a 128k -vn input_audio_128k.mp4

docker run -v D:\media:/media -it --rm google/shaka-packager

packager input=input_audio_128k.mp4,stream=audio,output=audio.mp4,drm_label=AUDIO \
	   input=input_video_640x360_750k.mp4,stream=video,output=video_360.mp4,drm_label=SD \
	   input=input_video_1280x720_1500k.mp4,stream=video,output=video_720.mp4,drm_label=HD \
     --enable_raw_key_encryption \
  	 --keys label=AUDIO:key_id=f3c5e0361e6654b28f8049c778b23946:key=a4631a153a443df9eed0593043db7519,label=SD:key_id=abba271e8bcf552bbd2e86a434a9a5d9:key=69eaa802a6763af979e8d1940fb88392,label=HD:key_id=6d76f25cb17f5e16b8eaef6bbf582d8e:key=cb541084c99731aef4fff74500c12ead \
     --protection_systems Widevine,PlayReady \
     --mpd_output h264.mpd
