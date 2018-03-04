extends AnimatedSprite

var tempElapsed = 0

func _ready():
   set_process(true)
   
func _process(delta):
	print(delta)
	var check = false
	tempElapsed = tempElapsed + delta   
	if(tempElapsed > 1.6):
		var animate = self.get_animation()
		print(self.get_sprite_frames().get_frame_count(animate))
		if(get_frame() == self.get_sprite_frames().get_frame_count(animate)-1):   
			set_frame(1)	
		else:
			self.set_frame(get_frame() + 1) 
		tempElapsed = 0  
	#print(str(get_frame() + 1))