import sys
import bitstring

def convertRegToInt(reg):
	tempStr = reg[1:]
	return tempStr

def compileInstr(machCode, instr, target):

	if(instr.lower() == "set"):
		tempInt = int(target)
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
		machCode.write("0" + bit + "      //" + instr + " " + target + "\n")
	
	elif(instr.lower() == "halt"):
		machCode.write("100000000" + "      //" + instr + "\n")
	
	elif(instr.lower() == "add"):
		tempInt = convertRegToInt(target)
		bit = '{0:04b}'.format(int(tempInt))
		machCode.write("10001" + bit + "      //" + instr + " " + target + "\n")
	
	elif(instr.lower() == "sub"):
		tempInt = convertRegToInt(target)
		bit = '{0:04b}'.format(int(tempInt))
		machCode.write("10010" + bit + "      //" + instr + " " + target + "\n")
	
	elif(instr.lower() == "st"):
		tempInt = convertRegToInt(target)
		bit = '{0:04b}'.format(int(tempInt))
		machCode.write("10011" + bit + "      //" + instr + " " + target + "\n")
	
	elif(instr.lower() == "ld"):
		tempInt = convertRegToInt(target)
		bit = '{0:04b}'.format(int(tempInt))
		machCode.write("10100" + bit + "      //" + instr + " " + target + "\n")
	
	elif(instr.lower() == "j"):
		machCode.write("101010000" + "      //" + instr + " " + target + "\n")
	
	elif(instr.lower() == "equal"):
		tempInt = convertRegToInt(target)
		bit = '{0:04b}'.format(int(tempInt))
		machCode.write("10110" + bit + "      //" + instr + " " + target + "\n")
	
	elif(instr.lower() == "beq"):
		machCode.write("101110000" + "      //" + instr + " " + target + "\n")
	
	elif(instr.lower() == "sl"):
		
		bit = '{0:04b}'.format(int(target))
		machCode.write("11000" + bit + "      //" + instr + " " + target + "\n")
	
	elif(instr.lower() == "sr"):
		bit = '{0:04b}'.format(int(target))
		machCode.write("11001" + bit + "      //" + instr + " " + target + "\n")
	
	elif(instr.lower() == "nor"):
		tempInt = convertRegToInt(target)
		bit = '{0:04b}'.format(int(tempInt))
		machCode.write("11010" + bit + "      //" + instr + " " + target + "\n")

	elif(instr.lower() == "or"):
		tempInt = convertRegToInt(target)
		bit = '{0:04b}'.format(int(tempInt))
		machCode.write("11011" + bit + "      //" + instr + " " + target + "\n")
			
	elif(instr.lower() == "and"):
		tempInt = convertRegToInt(target)
		bit = '{0:04b}'.format(int(tempInt))
		machCode.write("11100" + bit + "      //" + instr + " " + target + "\n")

	elif(instr.lower() == "lt"):
		tempInt = convertRegToInt(target)
		bit = '{0:04b}'.format(int(tempInt))
		machCode.write("11101" + bit + "      //" + instr + " " + target + "\n")
	
	elif(instr.lower() == "sta"):
		tempInt = convertRegToInt(target)
		bit = '{0:04b}'.format(int(tempInt))
		machCode.write("11110" + bit + "      //" + instr + " " + target + "\n")
	
	elif(instr.lower() == "asr"):
		bit = '{0:04b}'.format(int(target))
		machCode.write("11111" + bit + "      //" + instr + " " + target + "\n")
		
		
def main():
	machCode = open('div_machine.txt', 'w')

	with open("div_assembling.txt") as f:
		lines = f.readlines()

	instructions = [] 
	for line in lines:
		instructions += line.replace('\t', '\n').split('\n')
	#print instructions

	for instr in instructions:
		walk = instr.split(' ')
		#print walk
		if (instr.lower() == "halt") or (instr.lower() == "j") or (instr.lower() == "beq"):
			compileInstr(machCode, walk[0], " ")
		if (len(walk) > 1):
			compileInstr(machCode, walk[0], walk[1])



if __name__ == "__main__":
	main()