extends Control
class_name InterfacePage

var ag: ActiveGame


func Activate(ag: ActiveGame):
	show()
	
	self.ag = ag

func Close():
	hide()
