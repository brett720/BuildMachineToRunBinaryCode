import sys


def convertRegToInt(reg):
	tempStr = reg[1:]
	return tempStr

def compileInstr(machCode, instr, target,labels,index):
	tempInt = 0
	if(instr.lower() == "set"):
		if target.isdigit():
			tempInt = int(target)
		else:
			labelAt = labels[target]
			print "label is at "+str(labelAt)+" current line: " +str(index)
			if index > tempInt:
				tempInt = labelAt - index
			else:
				tempInt = index - labelAt
			print "jump " + str(tempInt)


		neg = 0
		if(tempInt < 0):
			neg = 1
			tempInt = -1 * tempInt

		bit = '{0:08b}'.format(int(tempInt))

		if(neg == 1):
			newString = ""
			for i in range(len(bit)):
				if bit[i] == '1' and i != 7:
					newString += '0'
				elif i != 7:
					newString += '1'
			newString += bit[7]
			bit = newString 

		
		#print bit
		machCode.write("0" + bit +"\n")
	
	elif(instr.lower() == "halt"):
		machCode.write("100000000" + "\n")
	
	elif(instr.lower() == "add"):
		tempInt = convertRegToInt(target)
		bit = '{0:04b}'.format(int(tempInt))
		machCode.write("10001" + bit+ "\n")
	
	elif(instr.lower() == "sub"):
		tempInt = convertRegToInt(target)
		bit = '{0:04b}'.format(int(tempInt))
		machCode.write("10010" + bit + "\n")
	
	elif(instr.lower() == "st"):
		tempInt = convertRegToInt(target)
		bit = '{0:04b}'.format(int(tempInt))
		machCode.write("10011" + bit + "\n")
	
	elif(instr.lower() == "ld"):
		tempInt = convertRegToInt(target)
		bit = '{0:04b}'.format(int(tempInt))
		machCode.write("10100" + bit+"\n")
	
	elif(instr.lower() == "j"):
		machCode.write("101010000"  + "\n")
	
	elif(instr.lower() == "equal"):
		tempInt = convertRegToInt(target)
		bit = '{0:04b}'.format(int(tempInt))
		machCode.write("10110" + bit + "\n")
	
	elif(instr.lower() == "beq"):
		machCode.write("101110000"  + "\n")
	
	elif(instr.lower() == "sl"):
		
		bit = '{0:04b}'.format(int(target))
		machCode.write("11000" + bit+ "\n")
	
	elif(instr.lower() == "sr"):
		bit = '{0:04b}'.format(int(target))
		machCode.write("11001" + bit+ "\n")
	
	elif(instr.lower() == "nor"):
		tempInt = convertRegToInt(target)
		bit = '{0:04b}'.format(int(tempInt))
		machCode.write("11010" + bit + "\n")

	elif(instr.lower() == "or"):
		tempInt = convertRegToInt(target)
		bit = '{0:04b}'.format(int(tempInt))
		machCode.write("11011" + bit+ "\n")
			
	elif(instr.lower() == "and"):
		tempInt = convertRegToInt(target)
		bit = '{0:04b}'.format(int(tempInt))
		machCode.write("11100" + bit + "\n")

	elif(instr.lower() == "lt"):
		tempInt = convertRegToInt(target)
		bit = '{0:04b}'.format(int(tempInt))
		machCode.write("11101" + bit + "\n")
	
	elif(instr.lower() == "sta"):
		tempInt = convertRegToInt(target)
		bit = '{0:04b}'.format(int(tempInt))
		machCode.write("11110" + bit  + "\n")
	
	elif(instr.lower() == "asr"):
		bit = '{0:04b}'.format(int(target))
		machCode.write("11111" + bit + "\n")
		


def main():
	machCode = open('assemblingTest_machineCode.txt', 'w')
	labels = {}
	
	with open("assemblingTest.txt") as f:
		lines = f.readlines()

	instructions = [] 
	for line in lines:
		instructions += line.replace('\t', '\n').split('\n')
	
	lineNum = 1
	for instr in instructions:
		if(instr != ""):
			#print instr
			if instr[0:5] == "label":
				word = instr[6:]
				labels[word] = lineNum
			else:
				lineNum +=1
	print labels
	index = 0
	for instr in instructions:
		walk = instr.split(' ')
		#print walk
		
		if (instr.lower() == "halt") or (instr.lower() == "j") or (instr.lower() == "beq"):
			index += 1
			compileInstr(machCode, walk[0], " ", labels,index)

		if (len(walk) > 1):
			index += 1
			compileInstr(machCode, walk[0], walk[1],labels,index)



if __name__ == "__main__":
	main()