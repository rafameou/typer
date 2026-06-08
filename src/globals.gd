class_name g

#n q a z e
static var dificuldade_tutorial = "n"
# f m d a t
static var dificuldade = "f"

# jogo normal, false para tutorial
static var n = true

static var tuto_bump = 0
static var nivel_bump = 0

static var time = null
static var tempo_passado_seg = 0
static var tempo_passado_seg_total = 0

static var qnt_tecladas = 0
static var qnt_tecladas_total = 0

static var qnt_palavras = 0
static var qnt_palavras_total = 0

static var qnt_erros = 0
static var qnt_erros_total = 0

static var lpm = 0.0
static var lpm_total = 0.0

static var wpm = 0.0
static var wpm_total = 0.0

const palavras_tutorial_num = [
	"12345",
	"12345",
	"67890",
	"67890",
]

const palavras_tutorial_qwerty = [
	"QWER",
	"QWERT",
	"QWERT",
	"YUIOP",
	"YUIOP",
]

const palavras_tutorial_asdf = [
	"ASDF",
	"ASDFG",
	"ASDFG",
	"HJKL",
	"HJKL",
]

const palavras_tutorial_zxcv = [
	"ZXCV",
	"ZXCV",
	"ZXCVB",
	"BNM",
	"BNM"
]

const palavras_tutorial_espaco = [
	"Q W E R T",
	"A S D F G",
	"Z X C V B",
	"Y U I O P",
	"H J K L",
	"B N M"
]

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
	"SEM´AFORO",
	"SUSTENT´AVEL",
	"EFICIÊNCIA", #trocar?
	"AUTOMAÇ~AO",
	"CONEX~AO",
	"ILUMINAÇ~AO",
]

const trocas = {
	"Semicolon" : "ç",
	"BracketLeft" : "´",
	"Apostrophe": "~",
	"Shift": "!"
}

#https://www.keybr.com/
const dedo_correto = {
	#mindinho esquerdo
	"1" : 1,
	"Q" : 1,
	"A" : 1,
	"Z" : 1,
	#anelar esquerdo
	"2" : 2,
	"W" : 2,
	"S" : 2,
	"X" : 2,
	#medio esquerdo
	"3" : 3,
	"E" : 3,
	"D" : 3,
	"C" : 3,
	#indicador esquerdo
	"4" : 4,
	"5" : 4,
	"R" : 4,
	"T" : 4,
	"F" : 4,
	"G" : 4,
	"V" : 4,
	"B" : 4,
	#indicador direito
	"6" : 7,
	"7" : 7,
	"Y" : 7,
	"U" : 7,
	"H" : 7,
	"J" : 7,
	"N" : 7,
	"M" : 7,
	#medio direito
	"8" : 8,
	"I" : 8,
	"K" : 8,
	"," : 8,
	#anelar direito
	"9" : 9,
	"O" : 9,
	"L" : 9,
	"." : 9,
	#mindinho direito
	"0" : 10,
	"P" : 10,
	"Ç" : 10,
	"til" : 10,
	#polegar
	"espaço_A" : 5, #letra-1 menor que 5
	"espaço_B" : 6, #letra-1 maior que 5
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
