class_name g

# f m d a t
static var dificuldade = "f"

const palavras_facil = [
	"CARROS",
	"REDES",
	"NUVEM",
	"DADOS",
	"VERDE",
	"IOT"
]

const palavras_medias = [
	"SENSORES",
	"INTERNET",
	"CONECTADO",
	"CONTROLE",
	"CADASTRO"
]

const palavras_dificeis = [
	"TRANSPORTE",
	"CONECTIVIDADE",
	"TECNOLOGIA",
	"SOFTWARE",
	"DIGITAL",
]

const palavras_acentos = [
	"SEMÁFORO", #"SEM´AFORO"
	"SUSTENTÁVEL",
	"EFICIÊNCIA",
	"AUTOMAÇÃO",
	"CONEXÃO",
	"ILUMINAÇÃO",
]

#https://www.keybr.com/
const dedo_correto = {
	#mindinho esquerdo
	"1" : "1E",
	"Q" : "1E",
	"A" : "1E",
	"Z" : "1E",
	#anelar esquerdo
	"2" : "2E",
	"W" : "2E",
	"S" : "2E",
	"X" : "2E",
	#medio esquerdo
	"3" : "3E",
	"E" : "3E",
	"D" : "3E",
	"C" : "3E",
	#indicador esquerdo
	"4" : "4E",
	"5" : "4E",
	"R" : "4E",
	"T" : "4E",
	"F" : "4E",
	"G" : "4E",
	"V" : "4E",
	"B" : "4E",
	#indicador direito
	"6" : "4D",
	"7" : "4D",
	"Y" : "4D",
	"U" : "4D",
	"H" : "4D",
	"J" : "4D",
	"N" : "4D",
	"M" : "4D",
	#medio direito
	"8" : "3D",
	"I" : "3D",
	"K" : "3D",
	"," : "3D",
	#anelar direito
	"9" : "2D",
	"O" : "2D",
	"L" : "2D",
	"." : "2D",
	#mindinho direito
	"0" : "1D",
	"P" : "1D",
	"Ç" : "1D",
	"til" : "1D",
	#polegar
	"espaço" : "P"
}

const vizinhos = {
	"1": ["2", "Q"],
	"2": ["1", "3", "Q", "W"],
	"3": ["2", "4", "W", "E"],
	"4": ["3", "5", "E", "R"],
	"5": ["4", "6", "R", "T"],
	"6": ["5", "7", "T", "Y"],
	"7": ["6", "8", "Y", "U"],
	"8": ["7", "9", "U", "I"],
	"9": ["8", "0", "I", "O"],
	"0": ["9", "-", "O", "P"],
	"-": ["0", "=", "P", "["],
	"=": ["-", "[", "]"],
	"Q": ["TAB", "caps", "1", "2", "W", "A"],
	"W": ["1", "2", "3", "Q", "E", "A", "S"],
	"E": ["2", "3", "4", "W", "R", "S", "D"],
	"R": ["3", "4", "5", "E", "T", "D", "F"],
	"T": ["4", "5", "6", "R", "Y", "F", "G"],
	"Y": ["5", "6", "7", "T", "U", "G", "H"],
	"U": ["6", "7", "8", "Y", "I", "H", "J"],
	"I": ["7", "8", "9", "U", "O", "J", "K"],
	"O": ["8", "9", "0", "I", "P", "K", "L"],
	"P": ["9", "0", "-", "O", "[", "L", "Semicolon"],
	"[": ["0", "-", "=", "P", "]", "Semicolon", "til"],
	"]": ["-", "=", "[", "til"],
	"A": ["TAB", "caps", "shift", "Q", "W", "S", "Z"],
	"S": ["Q", "W", "E", "A", "D", "Z", "X"],
	"D": ["W", "E", "R", "S", "F", "X", "C"],
	"F": ["E", "R", "T", "D", "G", "C", "V"],
	"G": ["R", "T", "Y", "F", "H", "V", "B"],
	"H": ["T", "Y", "U", "G", "J", "B", "N"],
	"J": ["Y", "U", "I", "H", "K", "N", "M"],
	"K": ["U", "I", "O", "J", "L", "M", ","],
	"L": ["I", "O", "P", "K", "Semicolon", ",", "."],
	"Semicolon": ["O", "P", "[", "L", "til", ".", ";"],
	"til": ["P", "[", "]", "Semicolon", ";"],
	"Z": ["caps", "shift", "CTRL", "A", "S", "X"],
	"X": ["A", "S", "D", "Z", "C"],
	"C": ["S", "D", "F", "X", "V"],
	"V": ["D", "F", "G", "C", "B"],
	"B": ["F", "G", "H", "V", "N"],
	"N": ["G", "H", "J", "B", "M"],
	"M": ["H", "J", "K", "N", "<"],
	"<": ["J", "K", "L", "M", ">"],
	">": ["K", "L", "Semicolon", "<", ";"],
	";": ["L", "Semicolon", "til", ">"]
}
