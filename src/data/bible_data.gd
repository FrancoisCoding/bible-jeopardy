extends RefCounted
class_name BibleData

const CATEGORY_NAMES := [
	{"en": "Genesis", "pt": "Gênesis"},
	{"en": "Moses & the Exodus", "pt": "Moisés e o Êxodo"},
	{"en": "Joshua & the Promised Land", "pt": "Josué e a Terra Prometida"},
	{"en": "David the Shepherd King", "pt": "Davi, o Rei Pastor"},
	{"en": "Psalms & Worship", "pt": "Salmos e Adoração"},
	{"en": "Proverbs & Wisdom", "pt": "Provérbios e Sabedoria"},
	{"en": "Major Prophets", "pt": "Profetas Maiores"},
	{"en": "Minor Prophets", "pt": "Profetas Menores"},
	{"en": "Women of the Old Testament", "pt": "Mulheres do Antigo Testamento"},
	{"en": "Miracles in the Old Testament", "pt": "Milagres no Antigo Testamento"},
	{"en": "Birth of Jesus", "pt": "Nascimento de Jesus"},
	{"en": "Miracles of Jesus", "pt": "Milagres de Jesus"},
	{"en": "Parables of Jesus", "pt": "Parábolas de Jesus"},
	{"en": "Teachings of Jesus", "pt": "Ensinos de Jesus"},
	{"en": "Death & Resurrection of Jesus", "pt": "Morte e Ressurreição de Jesus"},
	{"en": "Disciples & Apostles", "pt": "Discípulos e Apóstolos"},
	{"en": "Early Church (Acts)", "pt": "Igreja Primitiva (Atos)"},
	{"en": "Journeys of Paul", "pt": "Viagens de Paulo"},
	{"en": "Letters of Paul", "pt": "Cartas de Paulo"},
	{"en": "Churches in Revelation", "pt": "Igrejas em Apocalipse"},
	{"en": "Bible Geography", "pt": "Geografia Bíblica"},
	{"en": "Cities of the Bible", "pt": "Cidades da Bíblia"},
	{"en": "Animals in the Bible", "pt": "Animais na Bíblia"},
	{"en": "Dreams & Visions", "pt": "Sonhos e Visões"},
	{"en": "Faith & Trust Stories", "pt": "Histórias de Fé e Confiança"},
	{"en": "Forgiveness & Grace", "pt": "Perdão e Graça"},
	{"en": "Courage & Boldness", "pt": "Coragem e Ousadia"},
	{"en": "Famous Bible Quotes", "pt": "Frases Famosas da Bíblia"},
	{"en": "Who Said It?", "pt": "Quem Disse Isso?"},
	{"en": "Heroes of Faith (Hebrews 11)", "pt": "Heróis da Fé (Hebreus 11)"},
	{"en": "Kings of Israel & Judah", "pt": "Kings of Israel & Judah"},
	{"en": "Judges & Deliverers", "pt": "Judges & Deliverers"},
	{"en": "Tabernacle & Temple", "pt": "Tabernacle & Temple"},
	{"en": "Feasts & Festivals", "pt": "Feasts & Festivals"},
	{"en": "Covenants & Promises", "pt": "Covenants & Promises"},
	{"en": "Mountains & Wilderness Moments", "pt": "Mountains & Wilderness Moments"},
	{"en": "Encounters with Angels", "pt": "Encounters with Angels"},
	{"en": "Prayer & Fasting", "pt": "Prayer & Fasting"},
	{"en": "Battles & Warfare", "pt": "Battles & Warfare"},
	{"en": "Titles & Names of Jesus", "pt": "Titles & Names of Jesus"}
]

const VALUES: Array[int] = [100, 200, 300, 400, 500]
const LARGE_POOL_CATEGORIES := 10
const LARGE_POOL_COUNT := 4
const SMALL_POOL_COUNT := 3


# Helper para pegar o nome da categoria no idioma certo
static func get_category_name(cat_index: int, lang: String = "en") -> String:
	if cat_index < 0 or cat_index >= CATEGORY_NAMES.size():
		return ""
	var cat = CATEGORY_NAMES[cat_index]
	return cat.get(lang, cat["en"])


const BASE_QA := {
	"Genesis":
	[
		{
			"question":
			{
				"en": "Who was promised to Abraham and Sarah in their old age?",
				"pt": "Quem foi prometido a Abraão e Sara na velhice?"
			},
			"answer": {"en": "Isaac", "pt": "Isaque"},
			"tier": 1,
			"decoys":
			[
				{"en": "Ishmael", "pt": "Ismael"},
				{"en": "Jacob", "pt": "Jacó"},
				{"en": "Joseph", "pt": "José"}
			]
		},
		{
			"question":
			{
				"en": "Who wore a coat of many colors and was sold by his brothers?",
				"pt": "Quem vestiu um casaco de muitas cores e foi vendido pelos irmãos?"
			},
			"answer": {"en": "Joseph", "pt": "José"},
			"tier": 1,
			"decoys":
			[
				{"en": "Benjamin", "pt": "Benjamin"},
				{"en": "Judah", "pt": "Judá"},
				{"en": "Simeon", "pt": "Simeão"}
			]
		},
		{
			"question":
			{
				"en": "Where did God confuse human language so people scattered?",
				"pt": "Onde Deus confundiu a linguagem humana para que as pessoas se dispersassem?"
			},
			"answer": {"en": "Tower of Babel", "pt": "Torre de Babel"},
			"tier": 3,
			"decoys":
			[
				{"en": "Mount Sinai", "pt": "Monte Sinai"},
				{"en": "Nineveh", "pt": "Nínive"},
				{"en": "Shinar plain", "pt": "planície de Shinar"}
			]
		},
		{
			"question":
			{
				"en": "Who built an ark to survive the flood?",
				"pt": "Quem construiu uma arca para sobreviver ao dilúvio?"
			},
			"answer": {"en": "Noah", "pt": "Noé"},
			"tier": 1,
			"decoys":
			[
				{"en": "Moses", "pt": "Moisés"},
				{"en": "Abraham", "pt": "Abraão"},
				{"en": "Lot", "pt": "Muito"}
			]
		},
		{
			"question":
			{
				"en": "Who was tempted by the serpent in the garden?",
				"pt": "Quem foi tentado pela serpente no jardim?"
			},
			"answer": {"en": "Eve", "pt": "Véspera"},
			"tier": 1,
			"decoys":
			[
				{"en": "Sarah", "pt": "Sara"},
				{"en": "Rachel", "pt": "Raquel"},
				{"en": "Rebekah", "pt": "Rebeca"}
			]
		},
		{
			"question":
			{
				"en": "Who wrestled with an angel and was renamed Israel?",
				"pt": "Quem lutou com um anjo e foi renomeado como Israel?"
			},
			"answer": {"en": "Jacob", "pt": "Jacó"},
			"tier": 2,
			"decoys":
			[
				{"en": "Esau", "pt": "Esaú"},
				{"en": "Joseph", "pt": "José"},
				{"en": "Judah", "pt": "Judá"}
			]
		},
		{
			"question":
			{
				"en": "Which city did God destroy with fire alongside Sodom?",
				"pt": "Qual cidade Deus destruiu com fogo ao lado de Sodoma?"
			},
			"answer": {"en": "Gomorrah", "pt": "Gomorra"},
			"tier": 3,
			"decoys":
			[
				{"en": "Admah", "pt": "Admah"},
				{"en": "Zoar", "pt": "Zoar"},
				{"en": "Tyre", "pt": "Pneu"}
			]
		},
		{
			"question":
			{
				"en": "Who committed the first murder in Genesis?",
				"pt": "Quem cometeu o primeiro assassinato em Gênesis?"
			},
			"answer": {"en": "Cain", "pt": "Caim"},
			"tier": 1,
			"decoys":
			[
				{"en": "Abel", "pt": "Abel"},
				{"en": "Esau", "pt": "Esaú"},
				{"en": "Ham", "pt": "Presunto"}
			]
		},
		{
			"question":
			{
				"en": "Who is often called the father of faith?",
				"pt": "Quem é frequentemente chamado de pai da fé?"
			},
			"answer": {"en": "Abraham", "pt": "Abraão"},
			"tier": 1,
			"decoys":
			[
				{"en": "Isaac", "pt": "Isaque"},
				{"en": "Jacob", "pt": "Jacó"},
				{"en": "Terah", "pt": "Terá"}
			]
		},
		{
			"question":
			{"en": "Who was Jacob's beloved wife?", "pt": "Quem era a amada esposa de Jacó?"},
			"answer": {"en": "Rachel", "pt": "Raquel"},
			"tier": 1,
			"decoys":
			[
				{"en": "Leah", "pt": "Lia"},
				{"en": "Rebekah", "pt": "Rebeca"},
				{"en": "Sarah", "pt": "Sara"}
			]
		},
		{
			"question":
			{
				"en": "Who traded his birthright for a bowl of stew?",
				"pt": "Quem trocou seu direito de primogenitura por uma tigela de ensopado?"
			},
			"answer": {"en": "Esau", "pt": "Esaú"},
			"tier": 1,
			"decoys":
			[
				{"en": "Jacob", "pt": "Jacó"},
				{"en": "Ishmael", "pt": "Ismael"},
				{"en": "Ham", "pt": "Presunto"}
			]
		},
		{
			"question":
			{
				"en": "Where did Jacob dream of a ladder reaching heaven?",
				"pt": "Onde Jacó sonhou com uma escada que chegava ao céu?"
			},
			"answer": {"en": "Bethel", "pt": "Betel"},
			"tier": 2,
			"decoys":
			[
				{"en": "Beersheba", "pt": "Bersebá"},
				{"en": "Hebron", "pt": "Hebrom"},
				{"en": "Jericho", "pt": "Jericó"}
			]
		},
		{
			"question": {"en": "Who was Hagar's son?", "pt": "Quem era o filho de Hagar?"},
			"answer": {"en": "Ishmael", "pt": "Ismael"},
			"tier": 2,
			"decoys":
			[
				{"en": "Isaac", "pt": "Isaque"},
				{"en": "Midian", "pt": "Midiã"},
				{"en": "Esau", "pt": "Esaú"}
			]
		},
		{
			"question":
			{
				"en": "Which patriarch dug wells disputed by Philistines?",
				"pt": "Qual patriarca cavou poços disputados pelos filisteus?"
			},
			"answer": {"en": "Isaac", "pt": "Isaque"},
			"tier": 2,
			"decoys":
			[
				{"en": "Abraham", "pt": "Abraão"},
				{"en": "Jacob", "pt": "Jacó"},
				{"en": "Ishmael", "pt": "Ismael"}
			]
		},
		{
			"question":
			{
				"en": "Who dreamed the sun, moon, and stars bowed to him?",
				"pt": "Quem sonhou que o sol, a lua e as estrelas se curvavam diante dele?"
			},
			"answer": {"en": "Joseph", "pt": "José"},
			"tier": 2,
			"decoys":
			[
				{"en": "Benjamin", "pt": "Benjamin"},
				{"en": "Jacob", "pt": "Jacó"},
				{"en": "Pharaoh", "pt": "faraó"}
			]
		},
		{
			"question":
			{
				"en": "Who said his wife was his sister in Gerar?",
				"pt": "Quem disse que a esposa dele era irmã dele em Gerar?"
			},
			"answer": {"en": "Abraham", "pt": "Abraão"},
			"tier": 2,
			"decoys":
			[
				{"en": "Isaac", "pt": "Isaque"},
				{"en": "Jacob", "pt": "Jacó"},
				{"en": "Lot", "pt": "Muito"}
			]
		},
		{
			"question":
			{
				"en": "What land did God promise to Abraham's offspring?",
				"pt": "Que terra Deus prometeu à descendência de Abraão?"
			},
			"answer": {"en": "Canaan", "pt": "Canaã"},
			"tier": 2,
			"decoys":
			[
				{"en": "Goshen", "pt": "Gósen"},
				{"en": "Moab", "pt": "Moabe"},
				{"en": "Edom", "pt": "Edom"}
			]
		},
		{
			"question":
			{
				"en": "Who tricked Isaac by wearing goatskins?",
				"pt": "Quem enganou Isaque usando peles de cabra?"
			},
			"answer": {"en": "Jacob", "pt": "Jacó"},
			"tier": 2,
			"decoys":
			[
				{"en": "Esau", "pt": "Esaú"},
				{"en": "Rebekah", "pt": "Rebeca"},
				{"en": "Laban", "pt": "Labão"}
			]
		},
		{
			"question":
			{
				"en": "Who was Joseph's youngest brother?",
				"pt": "Quem era o irmão mais novo de José?"
			},
			"answer": {"en": "Benjamin", "pt": "Benjamin"},
			"tier": 1,
			"decoys":
			[
				{"en": "Simeon", "pt": "Simeão"},
				{"en": "Levi", "pt": "Levi"},
				{"en": "Judah", "pt": "Judá"}
			]
		},
		{
			"question":
			{
				"en": "Who was the father of the twelve tribes?",
				"pt": "Quem foi o pai das doze tribos?"
			},
			"answer": {"en": "Jacob", "pt": "Jacó"},
			"tier": 1,
			"decoys":
			[
				{"en": "Isaac", "pt": "Isaque"},
				{"en": "Abraham", "pt": "Abraão"},
				{"en": "Joseph", "pt": "José"}
			]
		},
		{
			"question":
			{
				"en": "What land did Lot choose when he parted from Abram?",
				"pt": "What land did Lot choose when he parted from Abram?"
			},
			"answer": {"en": "The Jordan plain", "pt": "The Jordan plain"},
			"tier": 2,
			"decoys":
			[
				{"en": "Hebron", "pt": "Hebron"},
				{"en": "Beersheba", "pt": "Beersheba"},
				{"en": "Shechem", "pt": "Shechem"}
			]
		},
		{
			"question":
			{
				"en": "What sign did God give Abraham to mark his covenant?",
				"pt": "What sign did God give Abraham to mark his covenant?"
			},
			"answer": {"en": "Circumcision", "pt": "Circumcision"},
			"tier": 2,
			"decoys":
			[
				{"en": "A rainbow", "pt": "A rainbow"},
				{"en": "Stone tablets", "pt": "Stone tablets"},
				{"en": "A bronze serpent", "pt": "A bronze serpent"}
			]
		},
		{
			"question":
			{
				"en": "Who bought the cave of Machpelah to bury Sarah?",
				"pt": "Who bought the cave of Machpelah to bury Sarah?"
			},
			"answer": {"en": "Abraham", "pt": "Abraham"},
			"tier": 3,
			"decoys":
			[
				{"en": "Isaac", "pt": "Isaac"},
				{"en": "Jacob", "pt": "Jacob"},
				{"en": "Joseph", "pt": "Joseph"}
			]
		},
		{
			"question":
			{
				"en": "Which king of Salem blessed Abram with bread and wine?",
				"pt": "Which king of Salem blessed Abram with bread and wine?"
			},
			"answer": {"en": "Melchizedek", "pt": "Melchizedek"},
			"tier": 3,
			"decoys":
			[
				{"en": "Abimelech", "pt": "Abimelech"},
				{"en": "Pharaoh", "pt": "Pharaoh"},
				{"en": "Laban", "pt": "Laban"}
			]
		},
		{
			"question":
			{
				"en": "Who unknowingly fathered Perez and Zerah with Tamar?",
				"pt": "Who unknowingly fathered Perez and Zerah with Tamar?"
			},
			"answer": {"en": "Judah", "pt": "Judah"},
			"tier": 3,
			"decoys":
			[
				{"en": "Onan", "pt": "Onan"},
				{"en": "Shelah", "pt": "Shelah"},
				{"en": "Reuben", "pt": "Reuben"}
			]
		},
		{
			"question":
			{
				"en": "What well did Hagar name Beer-lahai-roi after God saw her?",
				"pt": "What well did Hagar name Beer-lahai-roi after God saw her?"
			},
			"answer": {"en": "Beer-lahai-roi", "pt": "Beer-lahai-roi"},
			"tier": 3,
			"decoys":
			[
				{"en": "Beersheba", "pt": "Beersheba"},
				{"en": "En-rogel", "pt": "En-rogel"},
				{"en": "Elim", "pt": "Elim"}
			]
		},
		{
			"question":
			{
				"en": "On which mountain did Abraham prepare to sacrifice Isaac?",
				"pt": "On which mountain did Abraham prepare to sacrifice Isaac?"
			},
			"answer": {"en": "Mount Moriah", "pt": "Mount Moriah"},
			"tier": 3,
			"decoys":
			[
				{"en": "Mount Sinai", "pt": "Mount Sinai"},
				{"en": "Mount Ararat", "pt": "Mount Ararat"},
				{"en": "Mount Gerizim", "pt": "Mount Gerizim"}
			]
		},
		{
			"question":
			{
				"en": "Which woman died giving birth to Benjamin on the way to Ephrath?",
				"pt": "Which woman died giving birth to Benjamin on the way to Ephrath?"
			},
			"answer": {"en": "Rachel", "pt": "Rachel"},
			"tier": 3,
			"decoys":
			[
				{"en": "Leah", "pt": "Leah"},
				{"en": "Rebekah", "pt": "Rebekah"},
				{"en": "Dinah", "pt": "Dinah"}
			]
		},
		{
			"question":
			{
				"en": "Who found Rebekah at the well to be Isaac's wife?",
				"pt": "Who found Rebekah at the well to be Isaac's wife?"
			},
			"answer": {"en": "Abraham's servant", "pt": "Abraham's servant"},
			"tier": 3,
			"decoys":
			[
				{"en": "Elkanah", "pt": "Elkanah"},
				{"en": "Nahor", "pt": "Nahor"},
				{"en": "Bethuel", "pt": "Bethuel"}
			]
		},
		{
			"question":
			{
				"en": "Which city did Simeon and Levi attack after Dinah was wronged?",
				"pt": "Which city did Simeon and Levi attack after Dinah was wronged?"
			},
			"answer": {"en": "Shechem", "pt": "Shechem"},
			"tier": 3,
			"decoys":
			[
				{"en": "Hebron", "pt": "Hebron"},
				{"en": "Ai", "pt": "Ai"},
				{"en": "Bethel", "pt": "Bethel"}
			]
		}
	],
	"Moses & the Exodus":
	[
		{
			"question":
			{
				"en": "What sign did God give Moses at the burning bush?",
				"pt": "Que sinal Deus deu a Moisés na sarça ardente?"
			},
			"answer":
			{
				"en": "The bush burned but was not consumed",
				"pt": "A sarça queimou mas não foi consumida"
			},
			"tier": 2,
			"decoys":
			[
				{"en": "His hand turned leprous", "pt": "Sua mão ficou leprosa"},
				{"en": "Water became blood", "pt": "A água virou sangue"},
				{"en": "Staff to serpent", "pt": "Cajado para serpente"}
			]
		},
		{
			"question":
			{
				"en": "How many plagues struck Egypt before Israel left?",
				"pt": "Quantas pragas atingiram o Egito antes de Israel partir?"
			},
			"answer": {"en": "Ten", "pt": "Dez"},
			"tier": 3,
			"decoys":
			[
				{"en": "Seven", "pt": "Sete"},
				{"en": "Nine", "pt": "Nove"},
				{"en": "Twelve", "pt": "Doze"}
			]
		},
		{
			"question":
			{
				"en": "What meal marked Israel's escape from Egypt?",
				"pt": "Que refeição marcou a fuga de Israel do Egito?"
			},
			"answer": {"en": "Passover", "pt": "Páscoa"},
			"tier": 1,
			"decoys":
			[
				{"en": "Unleavened Bread", "pt": "Pão Ázimo"},
				{"en": "Firstfruits", "pt": "Primícias"},
				{"en": "Tabernacles", "pt": "Tabernáculos"}
			]
		},
		{
			"question":
			{
				"en": "Where did God give the Ten Commandments?",
				"pt": "Onde Deus deu os Dez Mandamentos?"
			},
			"answer": {"en": "Mount Sinai", "pt": "Monte Sinai"},
			"tier": 1,
			"decoys":
			[
				{"en": "Mount Horeb", "pt": "Monte Horebe"},
				{"en": "Mount Nebo", "pt": "Monte Nebo"},
				{"en": "Mount Carmel", "pt": "Monte Carmelo"}
			]
		},
		{
			"question":
			{
				"en": "Who held up Moses' arms during battle so Israel would prevail?",
				"pt":
				"Quem ergueu as armas de Moisés durante a batalha para que Israel prevalecesse?"
			},
			"answer": {"en": "Aaron and Hur", "pt": "Aarão e Hur"},
			"tier": 2,
			"decoys":
			[
				{"en": "Joshua and Caleb", "pt": "Josué e Calebe"},
				{"en": "Miriam and Zipporah", "pt": "Miriam e Zípora"},
				{"en": "Nadab and Abihu", "pt": "Nadabe e Abiú"}
			]
		},
		{
			"question":
			{
				"en": "What bread-like food fell from heaven for Israel?",
				"pt": "Que alimento semelhante a pão caiu do céu para Israel?"
			},
			"answer": {"en": "Manna", "pt": "Maná"},
			"tier": 1,
			"decoys":
			[
				{"en": "Quail", "pt": "Codorniz"},
				{"en": "Barley cakes", "pt": "Bolos de cevada"},
				{"en": "Fig cakes", "pt": "Bolos de figo"}
			]
		},
		{
			"question":
			{"en": "Who led Israel after Moses?", "pt": "Quem liderou Israel depois de Moisés?"},
			"answer": {"en": "Joshua", "pt": "Josué"},
			"tier": 1,
			"decoys":
			[
				{"en": "Caleb", "pt": "Calebe"},
				{"en": "Aaron", "pt": "Aarão"},
				{"en": "Gideon", "pt": "Gideão"}
			]
		},
		{
			"question":
			{
				"en": "What guided Israel by night during the Exodus?",
				"pt": "O que guiou Israel à noite durante o Êxodo?"
			},
			"answer": {"en": "A pillar of fire", "pt": "Uma coluna de fogo"},
			"tier": 1,
			"decoys":
			[
				{"en": "A cloud of glory", "pt": "Uma nuvem de glória"},
				{"en": "A bright star", "pt": "Uma estrela brilhante"},
				{"en": "A torch line", "pt": "Uma linha de tocha"}
			]
		},
		{
			"question":
			{
				"en": "What did Moses strike to bring water at Horeb?",
				"pt": "O que Moisés fez para levar água ao Horebe?"
			},
			"answer": {"en": "A rock", "pt": "Uma pedra"},
			"tier": 3,
			"decoys":
			[
				{"en": "The ground", "pt": "O chão"},
				{"en": "The Jordan", "pt": "O Jordão"},
				{"en": "A palm tree", "pt": "Uma palmeira"}
			]
		},
		{
			"question": {"en": "Who made the golden calf?", "pt": "Quem fez o bezerro de ouro?"},
			"answer": {"en": "Aaron", "pt": "Aarão"},
			"tier": 3,
			"decoys":
			[
				{"en": "Hur", "pt": "Hur"},
				{"en": "Korah", "pt": "Corá"},
				{"en": "Nadab", "pt": "Nadabe"}
			]
		},
		{
			"question":
			{
				"en": "Who rebelled and was swallowed by the earth?",
				"pt": "Quem se rebelou e foi engolido pela terra?"
			},
			"answer": {"en": "Korah", "pt": "Corá"},
			"tier": 2,
			"decoys":
			[
				{"en": "Dathan", "pt": "Datã"},
				{"en": "Abiram", "pt": "Abirão"},
				{"en": "Balaam", "pt": "Balaão"}
			]
		},
		{
			"question":
			{
				"en": "Which two spies gave a good report?",
				"pt": "Quais foram os dois espiões que deram um bom relatório?"
			},
			"answer": {"en": "Joshua and Caleb", "pt": "Josué e Calebe"},
			"tier": 2,
			"decoys":
			[
				{"en": "Joshua and Aaron", "pt": "Josué e Arão"},
				{"en": "Caleb and Hur", "pt": "Calebe e Hur"},
				{"en": "Eleazar and Phinehas", "pt": "Eleazar e Finéias"}
			]
		},
		{
			"question":
			{
				"en": "How many years did Israel wander in the wilderness?",
				"pt": "Quantos anos Israel vagou pelo deserto?"
			},
			"answer": {"en": "Forty", "pt": "Quarenta"},
			"tier": 1,
			"decoys":
			[
				{"en": "Twenty", "pt": "Vinte"},
				{"en": "Ten", "pt": "Dez"},
				{"en": "Seventy", "pt": "Setenta"}
			]
		},
		{
			"question":
			{
				"en": "On which mountain did Moses view the promised land?",
				"pt": "Em que montanha Moisés viu a terra prometida?"
			},
			"answer": {"en": "Mount Nebo", "pt": "Monte Nebo"},
			"tier": 2,
			"decoys":
			[
				{"en": "Mount Sinai", "pt": "Monte Sinai"},
				{"en": "Mount Carmel", "pt": "Monte Carmelo"},
				{"en": "Mount Ebal", "pt": "Monte Ebal"}
			]
		},
		{
			"question":
			{"en": "What did God write the law on?", "pt": "Sobre o que Deus escreveu a lei?"},
			"answer": {"en": "Two stone tablets", "pt": "Duas tábuas de pedra"},
			"tier": 1,
			"decoys":
			[
				{"en": "Bronze plates", "pt": "Placas de bronze"},
				{"en": "Scrolls", "pt": "Pergaminhos"},
				{"en": "Wooden boards", "pt": "Tábuas de madeira"}
			]
		},
		{
			"question": {"en": "Who was Moses' sister?", "pt": "Quem era a irmã de Moisés?"},
			"answer": {"en": "Miriam", "pt": "Míriam"},
			"tier": 1,
			"decoys":
			[
				{"en": "Zipporah", "pt": "Zípora"},
				{"en": "Deborah", "pt": "Débora"},
				{"en": "Hannah", "pt": "Ana"}
			]
		},
		{
			"question":
			{
				"en": "Where was baby Moses placed to be found?",
				"pt": "Onde o bebê Moisés foi colocado para ser encontrado?"
			},
			"answer": {"en": "In a basket on the Nile", "pt": "Em uma cesta no Nilo"},
			"tier": 1,
			"decoys":
			[
				{"en": "In a cave", "pt": "Em uma caverna"},
				{"en": "At a well in Midian", "pt": "Num poço em Midiã"},
				{"en": "In Pharaoh's court", "pt": "Na corte do Faraó"}
			]
		},
		{
			"question":
			{"en": "Who adopted Moses from the river?", "pt": "Quem adotou Moisés do rio?"},
			"answer": {"en": "Pharaoh's daughter", "pt": "Filha do Faraó"},
			"tier": 1,
			"decoys":
			[
				{"en": "Pharaoh's wife", "pt": "Esposa do Faraó"},
				{"en": "Miriam", "pt": "Míriam"},
				{"en": "Jochebed", "pt": "Joquebede"}
			]
		},
		{
			"question":
			{"en": "What was the last plague on Egypt?", "pt": "Qual foi a última praga no Egito?"},
			"answer": {"en": "Death of the firstborn", "pt": "Morte do primogênito"},
			"tier": 3,
			"decoys":
			[
				{"en": "Darkness", "pt": "Escuridão"},
				{"en": "Boils", "pt": "Furúnculos"},
				{"en": "Hail", "pt": "Saudação"}
			]
		},
		{
			"question":
			{
				"en": "What sea closed over Pharaoh's army?",
				"pt": "Que mar fechou sobre o exército do Faraó?"
			},
			"answer": {"en": "The Red Sea", "pt": "O Mar Vermelho"},
			"tier": 3,
			"decoys":
			[
				{"en": "The Dead Sea", "pt": "O Mar Morto"},
				{"en": "The Mediterranean", "pt": "O Mediterrâneo"},
				{"en": "The Nile", "pt": "O Nilo"}
			]
		},
		{
			"question":
			{
				"en": "Which tribe was set apart to carry the holy objects of the tabernacle?",
				"pt": "Which tribe was set apart to carry the holy objects of the tabernacle?"
			},
			"answer": {"en": "Levites", "pt": "Levites"},
			"tier": 2,
			"decoys":
			[
				{"en": "Judah", "pt": "Judah"},
				{"en": "Ephraim", "pt": "Ephraim"},
				{"en": "Reuben", "pt": "Reuben"}
			]
		},
		{
			"question":
			{
				"en": "In which wilderness did manna first appear?",
				"pt": "In which wilderness did manna first appear?"
			},
			"answer": {"en": "Wilderness of Sin", "pt": "Wilderness of Sin"},
			"tier": 2,
			"decoys":
			[
				{"en": "Wilderness of Paran", "pt": "Wilderness of Paran"},
				{"en": "Wilderness of Zin", "pt": "Wilderness of Zin"},
				{"en": "Wilderness of Shur", "pt": "Wilderness of Shur"}
			]
		},
		{
			"question":
			{
				"en":
				"On which day were the Israelites told to gather twice the manna for Sabbath rest?",
				"pt":
				"On which day were the Israelites told to gather twice the manna for Sabbath rest?"
			},
			"answer": {"en": "The sixth day", "pt": "The sixth day"},
			"tier": 2,
			"decoys":
			[
				{"en": "The fifth day", "pt": "The fifth day"},
				{"en": "The first day", "pt": "The first day"},
				{"en": "The seventh day", "pt": "The seventh day"}
			]
		},
		{
			"question":
			{
				"en": "On what mountain did Aaron die during the journey?",
				"pt": "On what mountain did Aaron die during the journey?"
			},
			"answer": {"en": "Mount Hor", "pt": "Mount Hor"},
			"tier": 2,
			"decoys":
			[
				{"en": "Mount Nebo", "pt": "Mount Nebo"},
				{"en": "Mount Sinai", "pt": "Mount Sinai"},
				{"en": "Mount Carmel", "pt": "Mount Carmel"}
			]
		},
		{
			"question":
			{
				"en":
				"Where did Moses strike the rock the second time when he was told to speak to it?",
				"pt":
				"Where did Moses strike the rock the second time when he was told to speak to it?"
			},
			"answer": {"en": "Meribah at Kadesh", "pt": "Meribah at Kadesh"},
			"tier": 2,
			"decoys":
			[
				{"en": "Rephidim", "pt": "Rephidim"},
				{"en": "Marah", "pt": "Marah"},
				{"en": "Elim", "pt": "Elim"}
			]
		},
		{
			"question":
			{
				"en": "Where did Israel camp between Migdol and the sea before it parted?",
				"pt": "Where did Israel camp between Migdol and the sea before it parted?"
			},
			"answer": {"en": "Pi-hahiroth", "pt": "Pi-hahiroth"},
			"tier": 3,
			"decoys":
			[
				{"en": "Succoth", "pt": "Succoth"},
				{"en": "Etham", "pt": "Etham"},
				{"en": "Penuel", "pt": "Penuel"}
			]
		},
		{
			"question":
			{
				"en": "Which midwives feared God and spared Hebrew baby boys?",
				"pt": "Which midwives feared God and spared Hebrew baby boys?"
			},
			"answer": {"en": "Shiphrah and Puah", "pt": "Shiphrah and Puah"},
			"tier": 3,
			"decoys":
			[
				{"en": "Jochebed and Miriam", "pt": "Jochebed and Miriam"},
				{"en": "Deborah and Jael", "pt": "Deborah and Jael"},
				{"en": "Zipporah and Elisheba", "pt": "Zipporah and Elisheba"}
			]
		},
		{
			"question":
			{
				"en": "On which day of the first month was the Passover lamb to be slain?",
				"pt": "On which day of the first month was the Passover lamb to be slain?"
			},
			"answer": {"en": "Fourteenth day", "pt": "Fourteenth day"},
			"tier": 3,
			"decoys":
			[
				{"en": "Tenth day", "pt": "Tenth day"},
				{"en": "Fifteenth day", "pt": "Fifteenth day"},
				{"en": "First day", "pt": "First day"}
			]
		},
		{
			"question":
			{
				"en":
				"Who advised Moses to appoint leaders of thousands, hundreds, fifties, and tens?",
				"pt":
				"Who advised Moses to appoint leaders of thousands, hundreds, fifties, and tens?"
			},
			"answer": {"en": "Jethro", "pt": "Jethro"},
			"tier": 3,
			"decoys":
			[
				{"en": "Hobab", "pt": "Hobab"},
				{"en": "Joshua", "pt": "Joshua"},
				{"en": "Eleazar", "pt": "Eleazar"}
			]
		},
		{
			"question":
			{
				"en": "What name was later given to the bronze serpent Moses lifted?",
				"pt": "What name was later given to the bronze serpent Moses lifted?"
			},
			"answer": {"en": "Nehushtan", "pt": "Nehushtan"},
			"tier": 3,
			"decoys":
			[
				{"en": "Leviathan", "pt": "Leviathan"},
				{"en": "Behemoth", "pt": "Behemoth"},
				{"en": "Rahab", "pt": "Rahab"}
			]
		}
	],
	"Joshua & the Promised Land":
	[
		{
			"question":
			{
				"en": "What city's walls fell after Israel marched and shouted?",
				"pt": "Que muralhas de cidade caíram depois que Israel marchou e gritou?"
			},
			"answer": {"en": "Jericho", "pt": "Jericó"},
			"tier": 1,
			"decoys":
			[
				{"en": "Ai", "pt": "Ai"},
				{"en": "Hazor", "pt": "Hazor"},
				{"en": "Gibeon", "pt": "Gibeão"}
			]
		},
		{
			"question":
			{
				"en": "Who sheltered the Israelite spies in Jericho?",
				"pt": "Quem abrigou os espiões israelitas em Jericó?"
			},
			"answer": {"en": "Rahab", "pt": "Raabe"},
			"tier": 1,
			"decoys":
			[
				{"en": "Deborah", "pt": "Débora"},
				{"en": "Jael", "pt": "Jael"},
				{"en": "Ruth", "pt": "Rute"}
			]
		},
		{
			"question":
			{
				"en": "Which river stopped flowing so Israel could cross?",
				"pt": "Qual rio parou de fluir para que Israel pudesse cruzar?"
			},
			"answer": {"en": "The Jordan River", "pt": "O rio Jordão"},
			"tier": 1,
			"decoys":
			[
				{"en": "The Euphrates", "pt": "O Eufrates"},
				{"en": "The Nile", "pt": "O Nilo"},
				{"en": "The Tigris", "pt": "O Tigre"}
			]
		},
		{
			"question":
			{"en": "Who led Israel after Moses?", "pt": "Quem liderou Israel depois de Moisés?"},
			"answer": {"en": "Joshua", "pt": "Josué"},
			"tier": 1,
			"decoys":
			[
				{"en": "Caleb", "pt": "Calebe"},
				{"en": "Aaron", "pt": "Aarão"},
				{"en": "Gideon", "pt": "Gideão"}
			]
		},
		{
			"question":
			{
				"en": "Which battle included the sun standing still?",
				"pt": "Qual batalha incluiu o sol parado?"
			},
			"answer": {"en": "Battle of Gibeon", "pt": "Batalha de Gibeão"},
			"tier": 1,
			"decoys":
			[
				{"en": "Battle of Ai", "pt": "Batalha de Ai"},
				{"en": "Battle of Jericho", "pt": "Batalha de Jericó"},
				{"en": "Battle of Merom", "pt": "Batalha de Merom"}
			]
		},
		{
			"question":
			{
				"en": "Who deceived Israel with moldy bread and worn sacks?",
				"pt": "Quem enganou Israel com pão mofado e sacos gastos?"
			},
			"answer": {"en": "The Gibeonites", "pt": "Os Gibeonitas"},
			"tier": 2,
			"decoys":
			[
				{"en": "The Philistines", "pt": "Os filisteus"},
				{"en": "The Moabites", "pt": "Os moabitas"},
				{"en": "The Amalekites", "pt": "Os Amalequitas"}
			]
		},
		{
			"question":
			{
				"en": "Who hid silver causing defeat at Ai?",
				"pt": "Quem escondeu a prata causando a derrota em Ai?"
			},
			"answer": {"en": "Achan", "pt": "Acã"},
			"tier": 2,
			"decoys":
			[
				{"en": "Caleb", "pt": "Calebe"},
				{"en": "Balaam", "pt": "Balaão"},
				{"en": "Korah", "pt": "Corá"}
			]
		},
		{
			"question":
			{
				"en": "How many stones were taken from the Jordan as a memorial?",
				"pt": "Quantas pedras foram retiradas do Jordão como memorial?"
			},
			"answer": {"en": "Twelve", "pt": "Doze"},
			"tier": 1,
			"decoys":
			[
				{"en": "Ten", "pt": "Dez"},
				{"en": "Seven", "pt": "Sete"},
				{"en": "Eight", "pt": "Oito"}
			]
		},
		{
			"question":
			{
				"en": "Where did Israel renew the covenant after crossing the Jordan?",
				"pt": "Onde Israel renovou a aliança depois de cruzar o Jordão?"
			},
			"answer": {"en": "Gilgal", "pt": "Gilgal"},
			"tier": 1,
			"decoys":
			[
				{"en": "Shechem", "pt": "Siquém"},
				{"en": "Shiloh", "pt": "Siló"},
				{"en": "Bethel", "pt": "Betel"}
			]
		},
		{
			"question":
			{
				"en": "What sacred object was carried around Jericho?",
				"pt": "Que objeto sagrado foi carregado ao redor de Jericó?"
			},
			"answer": {"en": "The Ark of the Covenant", "pt": "A Arca da Aliança"},
			"tier": 1,
			"decoys":
			[
				{"en": "A bronze altar", "pt": "Um altar de bronze"},
				{"en": "The lampstand", "pt": "O candelabro"},
				{"en": "The stones from Jordan", "pt": "As pedras da Jordânia"}
			]
		},
		{
			"question":
			{
				"en": "Who survived the wilderness to receive Hebron as inheritance?",
				"pt": "Quem sobreviveu ao deserto para receber Hebron como herança?"
			},
			"answer": {"en": "Caleb", "pt": "Calebe"},
			"tier": 2,
			"decoys":
			[
				{"en": "Joshua", "pt": "Josué"},
				{"en": "Othniel", "pt": "Otniel"},
				{"en": "Eleazar", "pt": "Eleazar"}
			]
		},
		{
			"question":
			{
				"en": "Where were Israel deceived into a treaty?",
				"pt": "Onde Israel foi enganado em um tratado?"
			},
			"answer": {"en": "Gibeon", "pt": "Gibeão"},
			"tier": 2,
			"decoys":
			[
				{"en": "Ai", "pt": "Ai"},
				{"en": "Hazor", "pt": "Hazor"},
				{"en": "Jericho", "pt": "Jericó"}
			]
		},
		{
			"question":
			{
				"en": "Which king led a northern coalition at the waters of Merom?",
				"pt": "Qual rei liderou uma coalizão do norte nas águas de Merom?"
			},
			"answer": {"en": "Jabin of Hazor", "pt": "Jabim de Hazor"},
			"tier": 3,
			"decoys":
			[
				{"en": "Adoni-Zedek", "pt": "Adoni-Zedeque"},
				{"en": "Balak", "pt": "Balaque"},
				{"en": "Og of Bashan", "pt": "Ogue de Basã"}
			]
		},
		{
			"question":
			{
				"en": "Where were blessings and curses read in Joshua?",
				"pt": "Onde as bênçãos e maldições foram lidas em Josué?"
			},
			"answer": {"en": "Mount Gerizim and Mount Ebal", "pt": "Monte Gerizim e Monte Ebal"},
			"tier": 1,
			"decoys":
			[
				{"en": "Mount Sinai and Horeb", "pt": "Monte Sinai e Horebe"},
				{"en": "Mount Tabor and Carmel", "pt": "Monte Tabor e Carmelo"},
				{"en": "Mount Zion and Moriah", "pt": "Monte Sião e Moriá"}
			]
		},
		{
			"question":
			{
				"en": "Where was the ark set after the land was divided?",
				"pt": "Onde a arca foi colocada depois que a terra foi dividida?"
			},
			"answer": {"en": "Shiloh", "pt": "Siló"},
			"tier": 2,
			"decoys":
			[
				{"en": "Bethel", "pt": "Betel"},
				{"en": "Gilgal", "pt": "Gilgal"},
				{"en": "Mizpah", "pt": "Mispá"}
			]
		},
		{
			"question":
			{
				"en": "Who asked Joshua for the hill country of Hebron?",
				"pt": "Quem pediu a Josué a região montanhosa de Hebron?"
			},
			"answer": {"en": "Caleb", "pt": "Calebe"},
			"tier": 1,
			"decoys":
			[
				{"en": "Phinehas", "pt": "Finéias"},
				{"en": "Othniel", "pt": "Otniel"},
				{"en": "Gideon", "pt": "Gideão"}
			]
		},
		{
			"question":
			{
				"en": "What river did eastern tribes build an altar beside?",
				"pt": "Ao lado de qual rio as tribos orientais construíram um altar?"
			},
			"answer": {"en": "The Jordan", "pt": "O Jordão"},
			"tier": 2,
			"decoys":
			[
				{"en": "The Arnon", "pt": "O Arnon"},
				{"en": "The Jabbok", "pt": "O Jaboque"},
				{"en": "The Euphrates", "pt": "O Eufrates"}
			]
		},
		{
			"question":
			{
				"en": "When did the Jordan stop flowing during flood stage?",
				"pt": "Quando o Jordão parou de fluir durante a fase de enchente?"
			},
			"answer":
			{
				"en": "When priests' feet touched the water",
				"pt": "Quando os pés dos padres tocaram a água"
			},
			"tier": 2,
			"decoys":
			[
				{"en": "When Joshua raised his staff", "pt": "Quando Josué ergueu seu cajado"},
				{"en": "After seven days of fasting", "pt": "Depois de sete dias de jejum"},
				{"en": "When stones were thrown in", "pt": "Quando pedras foram atiradas"}
			]
		},
		{
			"question":
			{
				"en": "What did Israel do at Gibeath Haaraloth before fighting?",
				"pt": "O que Israel fez em Gibeath Haaraloth antes de lutar?"
			},
			"answer": {"en": "They were circumcised", "pt": "Eles foram circuncidados"},
			"tier": 3,
			"decoys":
			[
				{"en": "They fasted seven days", "pt": "Eles jejuaram sete dias"},
				{"en": "They built an altar", "pt": "Eles construíram um altar"},
				{"en": "They sent envoys to Jericho", "pt": "Eles enviaram enviados a Jericó"}
			]
		},
		{
			"question":
			{
				"en": "Who met the commander of the Lord's army near Jericho?",
				"pt": "Quem encontrou o comandante do exército do Senhor perto de Jericó?"
			},
			"answer": {"en": "Joshua", "pt": "Josué"},
			"tier": 2,
			"decoys":
			[
				{"en": "Caleb", "pt": "Calebe"},
				{"en": "Phinehas", "pt": "Finéias"},
				{"en": "Gideon", "pt": "Gideão"}
			]
		},
		{
			"question":
			{
				"en": "Where did Joshua set up the twelve stones taken from the Jordan?",
				"pt": "Where did Joshua set up the twelve stones taken from the Jordan?"
			},
			"answer": {"en": "Gilgal", "pt": "Gilgal"},
			"tier": 2,
			"decoys":
			[
				{"en": "Shiloh", "pt": "Shiloh"},
				{"en": "Bethel", "pt": "Betel"},
				{"en": "Mizpah", "pt": "MispA?"}
			]
		},
		{
			"question":
			{
				"en": "Which city of refuge was in Galilee of Naphtali?",
				"pt": "Which city of refuge was in Galilee of Naphtali?"
			},
			"answer": {"en": "Kedesh", "pt": "Kedesh"},
			"tier": 2,
			"decoys":
			[
				{"en": "Shechem", "pt": "Shechem"},
				{"en": "Hebron", "pt": "Hebron"},
				{"en": "Golan", "pt": "Golan"}
			]
		},
		{
			"question":
			{
				"en": "In which book was the sun standing still recorded?",
				"pt": "In which book was the sun standing still recorded?"
			},
			"answer": {"en": "The Book of Jashar", "pt": "The Book of Jashar"},
			"tier": 3,
			"decoys":
			[
				{
					"en": "The Book of the Wars of the Lord",
					"pt": "The Book of the Wars of the Lord"
				},
				{"en": "Chronicles of Samuel", "pt": "Chronicles of Samuel"},
				{"en": "Chronicles of the kings of Judah", "pt": "Chronicles of the kings of Judah"}
			]
		},
		{
			"question":
			{
				"en": "What was the name of the valley where Achan was judged?",
				"pt": "What was the name of the valley where Achan was judged?"
			},
			"answer": {"en": "Valley of Achor", "pt": "Valley of Achor"},
			"tier": 3,
			"decoys":
			[
				{"en": "Valley of Jezreel", "pt": "Valley of Jezreel"},
				{"en": "Valley of Elah", "pt": "Valley of Elah"},
				{"en": "Valley of Siddim", "pt": "Valley of Siddim"}
			]
		},
		{
			"question":
			{
				"en": "What were the Gibeonites assigned to be after their treaty?",
				"pt": "What were the Gibeonites assigned to be after their treaty?"
			},
			"answer":
			{"en": "Woodcutters and water carriers", "pt": "Woodcutters and water carriers"},
			"tier": 3,
			"decoys":
			[
				{"en": "Gatekeepers and singers", "pt": "Gatekeepers and singers"},
				{"en": "Stone masons and scribes", "pt": "Stone masons and scribes"},
				{"en": "Armor bearers and scouts", "pt": "Armor bearers and scouts"}
			]
		},
		{
			"question":
			{
				"en": "What happened to Hazor after Joshua defeated it?",
				"pt": "What happened to Hazor after Joshua defeated it?"
			},
			"answer": {"en": "It was burned", "pt": "It was burned"},
			"tier": 3,
			"decoys":
			[
				{"en": "It became a tribute city", "pt": "It became a tribute city"},
				{"en": "It was spared for priests", "pt": "It was spared for priests"},
				{"en": "It was divided among Reuben", "pt": "It was divided among Reuben"}
			]
		},
		{
			"question":
			{
				"en": "What name did the eastern tribes give their altar by the Jordan?",
				"pt": "What name did the eastern tribes give their altar by the Jordan?"
			},
			"answer": {"en": "Witness (Ed)", "pt": "Witness (Ed)"},
			"tier": 3,
			"decoys":
			[
				{"en": "Peace", "pt": "Peace"},
				{"en": "Remembrance", "pt": "Remembrance"},
				{"en": "Hope", "pt": "Hope"}
			]
		},
		{
			"question":
			{
				"en": "Who cast lots with Joshua to divide the land among Israel?",
				"pt": "Who cast lots with Joshua to divide the land among Israel?"
			},
			"answer":
			{
				"en": "Eleazar the priest with tribal heads",
				"pt": "Eleazar the priest with tribal heads"
			},
			"tier": 3,
			"decoys":
			[
				{"en": "Phinehas alone", "pt": "Phinehas alone"},
				{"en": "Caleb and Phinehas", "pt": "Caleb and Phinehas"},
				{"en": "Joshua alone", "pt": "Joshua alone"}
			]
		},
		{
			"question":
			{
				"en": "Which town was given to Joshua as his inheritance?",
				"pt": "Which town was given to Joshua as his inheritance?"
			},
			"answer": {"en": "Timnath-serah", "pt": "Timnath-serah"},
			"tier": 3,
			"decoys":
			[
				{"en": "Shiloh", "pt": "Shiloh"},
				{"en": "Hebron", "pt": "Hebron"},
				{"en": "Bethel", "pt": "Bethel"}
			]
		},
		{
			"question":
			{
				"en":
				"What did Joshua do to the five Amorite kings after defeating them at Makkedah?",
				"pt":
				"What did Joshua do to the five Amorite kings after defeating them at Makkedah?"
			},
			"answer":
			{
				"en": "Hanged them on trees and sealed them in the cave",
				"pt": "Hanged them on trees and sealed them in the cave"
			},
			"tier": 3,
			"decoys":
			[
				{"en": "Sold them into slavery", "pt": "Sold them into slavery"},
				{"en": "Blinded them and released them", "pt": "Blinded them and released them"},
				{"en": "Sent them back under tribute", "pt": "Sent them back under tribute"}
			]
		}
	],
	"David the Shepherd King":
	[
		{
			"question":
			{
				"en": "Whom did David defeat with a sling and a stone?",
				"pt": "Quem Davi derrotou com uma funda e uma pedra?"
			},
			"answer": {"en": "Goliath", "pt": "Golias"},
			"tier": 1,
			"decoys":
			[
				{"en": "Ishbi-Benob", "pt": "Ishbi-Benob"},
				{"en": "Saul", "pt": "Saulo"},
				{"en": "Absalom", "pt": "Absalão"}
			]
		},
		{
			"question":
			{"en": "Which prophet anointed David king?", "pt": "Qual profeta ungiu Davi rei?"},
			"answer": {"en": "Samuel", "pt": "Samuel"},
			"tier": 1,
			"decoys":
			[
				{"en": "Nathan", "pt": "Natan"},
				{"en": "Gad", "pt": "Deus"},
				{"en": "Eli", "pt": "Eli"}
			]
		},
		{
			"question":
			{
				"en": "What instrument did David play for Saul?",
				"pt": "Que instrumento Davi tocou para Saul?"
			},
			"answer": {"en": "Harp", "pt": "Harpa"},
			"tier": 1,
			"decoys":
			[
				{"en": "Lyre", "pt": "Lira"},
				{"en": "Flute", "pt": "Flauta"},
				{"en": "Trumpet", "pt": "Trombeta"}
			]
		},
		{
			"question":
			{
				"en": "Who was David's closest friend?",
				"pt": "Quem era o amigo mais próximo de David?"
			},
			"answer": {"en": "Jonathan", "pt": "Jônatas"},
			"tier": 1,
			"decoys":
			[
				{"en": "Abner", "pt": "Abner"},
				{"en": "Joab", "pt": "Joabe"},
				{"en": "Abishai", "pt": "Abisai"}
			]
		},
		{
			"question":
			{
				"en": "From which city did David rule as king?",
				"pt": "De qual cidade Davi governou como rei?"
			},
			"answer": {"en": "Jerusalem", "pt": "Jerusalém"},
			"tier": 1,
			"decoys":
			[
				{"en": "Hebron", "pt": "Hebrom"},
				{"en": "Bethlehem", "pt": "Belém"},
				{"en": "Shiloh", "pt": "Siló"}
			]
		},
		{
			"question": {"en": "Which tribe was David from?", "pt": "De qual tribo Davi era?"},
			"answer": {"en": "Judah", "pt": "Judá"},
			"tier": 1,
			"decoys":
			[
				{"en": "Benjamin", "pt": "Benjamin"},
				{"en": "Levi", "pt": "Levi"},
				{"en": "Ephraim", "pt": "Efraim"}
			]
		},
		{
			"question":
			{
				"en": "Who rebuked David after his sin with Bathsheba?",
				"pt": "Quem repreendeu Davi após seu pecado com Bate-Seba?"
			},
			"answer": {"en": "Nathan", "pt": "Natan"},
			"tier": 2,
			"decoys":
			[
				{"en": "Gad", "pt": "Deus"},
				{"en": "Samuel", "pt": "Samuel"},
				{"en": "Abner", "pt": "Abner"}
			]
		},
		{
			"question":
			{"en": "What was David's father's name?", "pt": "Qual era o nome do pai de David?"},
			"answer": {"en": "Jesse", "pt": "Jessé"},
			"tier": 1,
			"decoys":
			[
				{"en": "Obed", "pt": "Obede"},
				{"en": "Boaz", "pt": "Boaz"},
				{"en": "Nahshon", "pt": "Nahshon"}
			]
		},
		{
			"question":
			{"en": "Who was David's first wife?", "pt": "Quem foi a primeira esposa de David?"},
			"answer": {"en": "Michal", "pt": "Mical"},
			"tier": 2,
			"decoys":
			[
				{"en": "Abigail", "pt": "Abigail"},
				{"en": "Bathsheba", "pt": "Bate-Seba"},
				{"en": "Ahinoam", "pt": "Ainoã"}
			]
		},
		{
			"question":
			{
				"en": "Who led the rebellion against David and was his son?",
				"pt": "Quem liderou a rebelião contra Davi e foi seu filho?"
			},
			"answer": {"en": "Absalom", "pt": "Absalão"},
			"tier": 2,
			"decoys":
			[
				{"en": "Amnon", "pt": "Amnom"},
				{"en": "Adonijah", "pt": "Adonias"},
				{"en": "Ithream", "pt": "Itream"}
			]
		},
		{
			"question":
			{
				"en": "Where did David hide from Saul in the wilderness?",
				"pt": "Onde Davi se escondeu de Saul no deserto?"
			},
			"answer": {"en": "En Gedi", "pt": "En-Gedi"},
			"tier": 2,
			"decoys":
			[
				{"en": "Ziklag", "pt": "Ziclague"},
				{"en": "Hebron", "pt": "Hebrom"},
				{"en": "Mahanaim", "pt": "Maanaim"}
			]
		},
		{
			"question":
			{
				"en": "Who struck down Abner on Joab's orders?",
				"pt": "Quem derrotou Abner por ordem de Joabe?"
			},
			"answer": {"en": "Asahel", "pt": "Asael"},
			"tier": 3,
			"decoys":
			[
				{"en": "Abishai", "pt": "Abisai"},
				{"en": "Ithai", "pt": "Itai"},
				{"en": "Benaiah", "pt": "Benaia"}
			]
		},
		{
			"question":
			{
				"en": "Who carried Uriah's death letter?",
				"pt": "Quem carregou a carta de falecimento de Urias?"
			},
			"answer": {"en": "Uriah himself", "pt": "O próprio Urias"},
			"tier": 2,
			"decoys":
			[
				{"en": "Joab", "pt": "Joabe"},
				{"en": "Abner", "pt": "Abner"},
				{"en": "Zadok", "pt": "Zadoque"}
			]
		},
		{
			"question":
			{
				"en": "Who told David 'You are the man'?",
				"pt": "Quem disse a David 'Você é o cara'?"
			},
			"answer": {"en": "Nathan", "pt": "Natan"},
			"tier": 2,
			"decoys":
			[
				{"en": "Gad", "pt": "Deus"},
				{"en": "Zadok", "pt": "Zadoque"},
				{"en": "Abiathar", "pt": "Abiatar"}
			]
		},
		{
			"question":
			{
				"en": "What Philistine city did David flee to under Achish?",
				"pt": "Para qual cidade filisteu Davi fugiu sob o comando de Aquis?"
			},
			"answer": {"en": "Gath", "pt": "Gate"},
			"tier": 2,
			"decoys":
			[
				{"en": "Ekron", "pt": "Ecrom"},
				{"en": "Ashdod", "pt": "Asdode"},
				{"en": "Ashkelon", "pt": "Ascalão"}
			]
		},
		{
			"question":
			{
				"en": "Which priest gave David consecrated bread?",
				"pt": "Qual sacerdote deu pão consagrado a Davi?"
			},
			"answer": {"en": "Ahimelech", "pt": "Aimeleque"},
			"tier": 3,
			"decoys":
			[
				{"en": "Abiathar", "pt": "Abiatar"},
				{"en": "Zadok", "pt": "Zadoque"},
				{"en": "Samuel", "pt": "Samuel"}
			]
		},
		{
			"question":
			{
				"en": "Who mocked David for dancing before the ark?",
				"pt": "Quem zombou de Davi por dançar diante da arca?"
			},
			"answer": {"en": "Michal", "pt": "Mical"},
			"tier": 2,
			"decoys":
			[
				{"en": "Bathsheba", "pt": "Bate-Seba"},
				{"en": "Abigail", "pt": "Abigail"},
				{"en": "Tamar", "pt": "Tamar"}
			]
		},
		{
			"question":
			{
				"en": "What city did David first rule before Jerusalem?",
				"pt": "Que cidade Davi governou primeiro antes de Jerusalém?"
			},
			"answer": {"en": "Hebron", "pt": "Hebrom"},
			"tier": 1,
			"decoys":
			[
				{"en": "Bethlehem", "pt": "Belém"},
				{"en": "Mahanaim", "pt": "Maanaim"},
				{"en": "Gibeah", "pt": "Gibeá"}
			]
		},
		{
			"question":
			{
				"en": "Who was David's general and nephew?",
				"pt": "Quem era o general e sobrinho de David?"
			},
			"answer": {"en": "Joab", "pt": "Joabe"},
			"tier": 1,
			"decoys":
			[
				{"en": "Abner", "pt": "Abner"},
				{"en": "Benaiah", "pt": "Benaia"},
				{"en": "Ithai", "pt": "Itai"}
			]
		},
		{
			"question":
			{
				"en": "Which psalm is ascribed to David's repentance after Bathsheba?",
				"pt": "Qual salmo é atribuído ao arrependimento de Davi depois de Bate-Seba?"
			},
			"answer": {"en": "Psalm 51", "pt": "Salmo 51"},
			"tier": 1,
			"decoys":
			[
				{"en": "Psalm 32", "pt": "Salmo 32"},
				{"en": "Psalm 38", "pt": "Salmo 38"},
				{"en": "Psalm 6", "pt": "Salmo 6"}
			]
		},
		{
			"question":
			{
				"en": "Which priest gave David holy bread and Goliath's sword?",
				"pt": "Which priest gave David holy bread and Goliath's sword?"
			},
			"answer": {"en": "Ahimelech", "pt": "Ahimelech"},
			"tier": 2,
			"decoys":
			[
				{"en": "Abiathar", "pt": "Abiathar"},
				{"en": "Zadok", "pt": "Zadok"},
				{"en": "Eli", "pt": "Eli"}
			]
		},
		{
			"question":
			{
				"en": "Who was the swift nephew of David killed by Abner?",
				"pt": "Who was the swift nephew of David killed by Abner?"
			},
			"answer": {"en": "Asahel", "pt": "Asahel"},
			"tier": 2,
			"decoys":
			[
				{"en": "Abishai", "pt": "Abishai"},
				{"en": "Joab", "pt": "Joab"},
				{"en": "Ithra", "pt": "Ithra"}
			]
		},
		{
			"question":
			{
				"en": "Where did David cut off Saul's robe instead of killing him?",
				"pt": "Where did David cut off Saul's robe instead of killing him?"
			},
			"answer": {"en": "A cave at En Gedi", "pt": "A cave at En Gedi"},
			"tier": 3,
			"decoys":
			[
				{"en": "The cave of Adullam", "pt": "The cave of Adullam"},
				{"en": "The wilderness of Ziph", "pt": "The wilderness of Ziph"},
				{"en": "The wilderness of Paran", "pt": "The wilderness of Paran"}
			]
		},
		{
			"question":
			{
				"en": "Who betrayed David by siding with Absalom?",
				"pt": "Who betrayed David by siding with Absalom?"
			},
			"answer": {"en": "Ahithophel", "pt": "Ahithophel"},
			"tier": 3,
			"decoys":
			[
				{"en": "Hushai", "pt": "Hushai"},
				{"en": "Doeg", "pt": "Doeg"},
				{"en": "Shimei", "pt": "Shimei"}
			]
		},
		{
			"question":
			{
				"en": "Which Philistine king gave David the town of Ziklag?",
				"pt": "Which Philistine king gave David the town of Ziklag?"
			},
			"answer": {"en": "Achish of Gath", "pt": "Achish of Gath"},
			"tier": 3,
			"decoys":
			[
				{"en": "Balak of Moab", "pt": "Balak of Moab"},
				{"en": "Abimelech of Gerar", "pt": "Abimelech of Gerar"},
				{"en": "Hadadezer of Zobah", "pt": "Hadadezer of Zobah"}
			]
		},
		{
			"question":
			{
				"en": "Whose house kept the ark for three months after Uzzah died?",
				"pt": "Whose house kept the ark for three months after Uzzah died?"
			},
			"answer": {"en": "Obed-Edom", "pt": "Obed-Edom"},
			"tier": 3,
			"decoys":
			[
				{"en": "Abinadab", "pt": "Abinadab"},
				{"en": "Zadok", "pt": "Zadok"},
				{"en": "Ithamar", "pt": "Ithamar"}
			]
		},
		{
			"question":
			{
				"en": "Who killed Absalom despite David's command to spare him?",
				"pt": "Who killed Absalom despite David's command to spare him?"
			},
			"answer": {"en": "Joab", "pt": "Joab"},
			"tier": 3,
			"decoys":
			[
				{"en": "Abishai", "pt": "Abishai"},
				{"en": "Ittai", "pt": "Ittai"},
				{"en": "Benaiah", "pt": "Benaiah"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet confronted David over Bathsheba?",
				"pt": "Which prophet confronted David over Bathsheba?"
			},
			"answer": {"en": "Nathan", "pt": "Nathan"},
			"tier": 3,
			"decoys":
			[
				{"en": "Gad", "pt": "Gad"},
				{"en": "Samuel", "pt": "Samuel"},
				{"en": "Ahijah", "pt": "Ahijah"}
			]
		},
		{
			"question":
			{
				"en": "Which giant nearly killed David but was slain by Abishai?",
				"pt": "Which giant nearly killed David but was slain by Abishai?"
			},
			"answer": {"en": "Ishbi-Benob", "pt": "Ishbi-Benob"},
			"tier": 3,
			"decoys":
			[
				{"en": "Goliath", "pt": "Goliath"},
				{"en": "Saph", "pt": "Saph"},
				{"en": "Lahmi", "pt": "Lahmi"}
			]
		},
		{
			"question":
			{
				"en": "What priestly town did Doeg the Edomite strike down?",
				"pt": "What priestly town did Doeg the Edomite strike down?"
			},
			"answer": {"en": "Nob", "pt": "Nob"},
			"tier": 3,
			"decoys":
			[
				{"en": "Shiloh", "pt": "Shiloh"},
				{"en": "Bethel", "pt": "Bethel"},
				{"en": "Gilgal", "pt": "Gilgal"}
			]
		}
	],
	"Psalms & Worship":
	[
		{
			"question":
			{
				"en": "Which psalm begins, 'The Lord is my shepherd'?",
				"pt": "Qual salmo começa com 'O Senhor é meu pastor'?"
			},
			"answer": {"en": "Psalm 23", "pt": "Salmo 23"},
			"tier": 1,
			"decoys":
			[
				{"en": "Psalm 27", "pt": "Salmo 27"},
				{"en": "Psalm 91", "pt": "Salmo 91"},
				{"en": "Psalm 121", "pt": "Salmo 121"}
			]
		},
		{
			"question":
			{"en": "Who wrote many of the psalms?", "pt": "Quem escreveu muitos dos salmos?"},
			"answer": {"en": "David", "pt": "Davi"},
			"tier": 1,
			"decoys":
			[
				{"en": "Asaph", "pt": "Asafe"},
				{"en": "Moses", "pt": "Moisés"},
				{"en": "Solomon", "pt": "Salomão"}
			]
		},
		{
			"question":
			{
				"en": "Which psalm calls for praising God with loud cymbals?",
				"pt": "Qual salmo exige louvar a Deus com címbalos altos?"
			},
			"answer": {"en": "Psalm 150", "pt": "Salmo 150"},
			"tier": 2,
			"decoys":
			[
				{"en": "Psalm 100", "pt": "Salmo 100"},
				{"en": "Psalm 67", "pt": "Salmo 67"},
				{"en": "Psalm 40", "pt": "Salmo 40"}
			]
		},
		{
			"question":
			{
				"en": "Which psalm asks, 'Create in me a clean heart'?",
				"pt": "Qual salmo pede: ‘Cria em mim um coração limpo’?"
			},
			"answer": {"en": "Psalm 51", "pt": "Salmo 51"},
			"tier": 1,
			"decoys":
			[
				{"en": "Psalm 32", "pt": "Salmo 32"},
				{"en": "Psalm 103", "pt": "Salmo 103"},
				{"en": "Psalm 119", "pt": "Salmo 119"}
			]
		},
		{
			"question":
			{
				"en": "What instrument family is often mentioned in the Psalms?",
				"pt": "Que família de instrumentos é frequentemente mencionada nos Salmos?"
			},
			"answer": {"en": "Stringed instruments", "pt": "Instrumentos de cordas"},
			"tier": 1,
			"decoys":
			[
				{"en": "Trumpets", "pt": "Trombetas"},
				{"en": "Tambourines", "pt": "Pandeiros"},
				{"en": "Cymbals", "pt": "Pratos"}
			]
		},
		{
			"question":
			{
				"en": "Which psalm is a song of ascent about unity?",
				"pt": "Qual salmo é um cântico de ascensão sobre a unidade?"
			},
			"answer": {"en": "Psalm 133", "pt": "Salmo 133"},
			"tier": 2,
			"decoys":
			[
				{"en": "Psalm 134", "pt": "Salmo 134"},
				{"en": "Psalm 120", "pt": "Salmo 120"},
				{"en": "Psalm 87", "pt": "Salmo 87"}
			]
		},
		{
			"question":
			{
				"en": "Which psalm starts with 'Blessed is the man'?",
				"pt": "Qual salmo começa com 'Bem-aventurado o homem'?"
			},
			"answer": {"en": "Psalm 1", "pt": "Salmo 1"},
			"tier": 1,
			"decoys":
			[
				{"en": "Psalm 2", "pt": "Salmo 2"},
				{"en": "Psalm 15", "pt": "Salmo 15"},
				{"en": "Psalm 37", "pt": "Salmo 37"}
			]
		},
		{
			"question":
			{
				"en": "Which psalm speaks of the Lord as a refuge and fortress?",
				"pt": "Qual salmo fala do Senhor como refúgio e fortaleza?"
			},
			"answer": {"en": "Psalm 91", "pt": "Salmo 91"},
			"tier": 1,
			"decoys":
			[
				{"en": "Psalm 46", "pt": "Salmo 46"},
				{"en": "Psalm 62", "pt": "Salmo 62"},
				{"en": "Psalm 18", "pt": "Salmo 18"}
			]
		},
		{
			"question":
			{
				"en": "Which psalm declares 'The earth is the Lord's and everything in it'?",
				"pt": "Qual salmo declara 'A terra é do Senhor e tudo o que nela há'?"
			},
			"answer": {"en": "Psalm 24", "pt": "Salmo 24"},
			"tier": 2,
			"decoys":
			[
				{"en": "Psalm 29", "pt": "Salmo 29"},
				{"en": "Psalm 33", "pt": "Salmo 33"},
				{"en": "Psalm 19", "pt": "Salmo 19"}
			]
		},
		{
			"question":
			{"en": "Which psalm is Moses credited with?", "pt": "A qual salmo Moisés é creditado?"},
			"answer": {"en": "Psalm 90", "pt": "Salmo 90"},
			"tier": 2,
			"decoys":
			[
				{"en": "Psalm 89", "pt": "Salmo 89"},
				{"en": "Psalm 72", "pt": "Salmo 72"},
				{"en": "Psalm 110", "pt": "Salmo 110"}
			]
		},
		{
			"question":
			{
				"en": "Which psalm is an acrostic on God's word?",
				"pt": "Qual salmo é um acróstico da palavra de Deus?"
			},
			"answer": {"en": "Psalm 119", "pt": "Salmo 119"},
			"tier": 3,
			"decoys":
			[
				{"en": "Psalm 19", "pt": "Salmo 19"},
				{"en": "Psalm 111", "pt": "Salmo 111"},
				{"en": "Psalm 112", "pt": "Salmo 112"}
			]
		},
		{
			"question":
			{
				"en": "Which psalm asks 'Whom have I in heaven but you?'",
				"pt": "Qual salmo pergunta 'Quem tenho eu no céu senão você?'"
			},
			"answer": {"en": "Psalm 73", "pt": "Salmo 73"},
			"tier": 2,
			"decoys":
			[
				{"en": "Psalm 63", "pt": "Salmo 63"},
				{"en": "Psalm 84", "pt": "Salmo 84"},
				{"en": "Psalm 42", "pt": "Salmo 42"}
			]
		},
		{
			"question":
			{
				"en": "Which psalm begins 'The Lord is my light and my salvation'?",
				"pt": "Qual salmo começa com 'O Senhor é minha luz e minha salvação'?"
			},
			"answer": {"en": "Psalm 27", "pt": "Salmo 27"},
			"tier": 1,
			"decoys":
			[
				{"en": "Psalm 26", "pt": "Salmo 26"},
				{"en": "Psalm 62", "pt": "Salmo 62"},
				{"en": "Psalm 86", "pt": "Salmo 86"}
			]
		},
		{
			"question":
			{
				"en": "Which psalm describes a shepherd leading to green pastures?",
				"pt": "Qual salmo descreve um pastor conduzindo a pastos verdejantes?"
			},
			"answer": {"en": "Psalm 23", "pt": "Salmo 23"},
			"tier": 1,
			"decoys":
			[
				{"en": "Psalm 34", "pt": "Salmo 34"},
				{"en": "Psalm 78", "pt": "Salmo 78"},
				{"en": "Psalm 80", "pt": "Salmo 80"}
			]
		},
		{
			"question":
			{
				"en": "Which psalm mourns 'My God, why have you forsaken me?'?",
				"pt": "Qual salmo lamenta 'Meu Deus, por que me abandonaste?'?"
			},
			"answer": {"en": "Psalm 22", "pt": "Salmo 22"},
			"tier": 3,
			"decoys":
			[
				{"en": "Psalm 31", "pt": "Salmo 31"},
				{"en": "Psalm 102", "pt": "Salmo 102"},
				{"en": "Psalm 130", "pt": "Salmo 130"}
			]
		},
		{
			"question":
			{
				"en": "Which psalm celebrates the King enthroned forever?",
				"pt": "Qual salmo celebra o Rei entronizado para sempre?"
			},
			"answer": {"en": "Psalm 45", "pt": "Salmo 45"},
			"tier": 3,
			"decoys":
			[
				{"en": "Psalm 2", "pt": "Salmo 2"},
				{"en": "Psalm 72", "pt": "Salmo 72"},
				{"en": "Psalm 110", "pt": "Salmo 110"}
			]
		},
		{
			"question":
			{
				"en": "Which psalm thanks God for being fearfully and wonderfully made?",
				"pt":
				"Qual salmo agradece a Deus por ter sido feito de maneira assombrosa e maravilhosa?"
			},
			"answer": {"en": "Psalm 139", "pt": "Salmo 139"},
			"tier": 3,
			"decoys":
			[
				{"en": "Psalm 104", "pt": "Salmo 104"},
				{"en": "Psalm 8", "pt": "Salmo 8"},
				{"en": "Psalm 147", "pt": "Salmo 147"}
			]
		},
		{
			"question":
			{
				"en": "Which psalm calls 'Bless the Lord, O my soul' repeatedly?",
				"pt": "Qual salmo chama repetidamente de 'Bendito seja o Senhor, ó minha alma'?"
			},
			"answer": {"en": "Psalm 103", "pt": "Salmo 103"},
			"tier": 1,
			"decoys":
			[
				{"en": "Psalm 104", "pt": "Salmo 104"},
				{"en": "Psalm 34", "pt": "Salmo 34"},
				{"en": "Psalm 145", "pt": "Salmo 145"}
			]
		},
		{
			"question":
			{
				"en": "Which psalm portrays the Good Shepherd's table in front of enemies?",
				"pt": "Qual salmo retrata a mesa do Bom Pastor diante dos inimigos?"
			},
			"answer": {"en": "Psalm 23", "pt": "Salmo 23"},
			"tier": 3,
			"decoys":
			[
				{"en": "Psalm 16", "pt": "Salmo 16"},
				{"en": "Psalm 61", "pt": "Salmo 61"},
				{"en": "Psalm 121", "pt": "Salmo 121"}
			]
		},
		{
			"question":
			{
				"en": "Which psalm declares 'Be still, and know that I am God'?",
				"pt": "Qual salmo declara 'Aquietai-vos e sabei que eu sou Deus'?"
			},
			"answer": {"en": "Psalm 46", "pt": "Salmo 46"},
			"tier": 1,
			"decoys":
			[
				{"en": "Psalm 62", "pt": "Salmo 62"},
				{"en": "Psalm 37", "pt": "Salmo 37"},
				{"en": "Psalm 73", "pt": "Salmo 73"}
			]
		},
		{
			"question":
			{
				"en": "Which psalm begins, 'As the deer pants for streams of water'?",
				"pt": "Qual salmo começa com 'Como a corsa anseia por águas correntes'?"
			},
			"answer": {"en": "Psalm 42", "pt": "Salmo 42"},
			"tier": 2,
			"decoys":
			[
				{"en": "Psalm 41", "pt": "Salmo 41"},
				{"en": "Psalm 63", "pt": "Salmo 63"},
				{"en": "Psalm 84", "pt": "Salmo 84"}
			]
		},
		{
			"question":
			{
				"en":
				"Which psalm is filled with the refrain, 'His steadfast love endures forever'?",
				"pt": "Qual salmo está cheio do refrão 'Seu amor dura para sempre'?"
			},
			"answer": {"en": "Psalm 136", "pt": "Salmo 136"},
			"tier": 2,
			"decoys":
			[
				{"en": "Psalm 118", "pt": "Salmo 118"},
				{"en": "Psalm 100", "pt": "Salmo 100"},
				{"en": "Psalm 34", "pt": "Salmo 34"}
			]
		},
		{
			"question":
			{
				"en": "Which psalm invites, 'Taste and see that the Lord is good'?",
				"pt": "Qual salmo convida: 'Provai e vede que o Senhor é bom'?"
			},
			"answer": {"en": "Psalm 34", "pt": "Salmo 34"},
			"tier": 2,
			"decoys":
			[
				{"en": "Psalm 103", "pt": "Salmo 103"},
				{"en": "Psalm 16", "pt": "Salmo 16"},
				{"en": "Psalm 84", "pt": "Salmo 84"}
			]
		},
		{
			"question":
			{
				"en": "Which psalm speaks of watchmen waiting for the morning?",
				"pt": "Qual salmo fala de sentinelas esperando pelo amanhecer?"
			},
			"answer": {"en": "Psalm 130", "pt": "Salmo 130"},
			"tier": 2,
			"decoys":
			[
				{"en": "Psalm 27", "pt": "Salmo 27"},
				{"en": "Psalm 121", "pt": "Salmo 121"},
				{"en": "Psalm 91", "pt": "Salmo 91"}
			]
		},
		{
			"question":
			{
				"en": "Which psalm proclaims, 'The heavens declare the glory of God'?",
				"pt": "Qual salmo proclama: 'Os céus proclamam a glória de Deus'?"
			},
			"answer": {"en": "Psalm 19", "pt": "Salmo 19"},
			"tier": 3,
			"decoys":
			[
				{"en": "Psalm 8", "pt": "Salmo 8"},
				{"en": "Psalm 33", "pt": "Salmo 33"},
				{"en": "Psalm 29", "pt": "Salmo 29"}
			]
		},
		{
			"question":
			{
				"en": "Which psalm commands, 'Lift up your heads, O gates'?",
				"pt": "Qual salmo ordena: 'Levantem-se, ó portas'?"
			},
			"answer": {"en": "Psalm 24", "pt": "Salmo 24"},
			"tier": 3,
			"decoys":
			[
				{"en": "Psalm 15", "pt": "Salmo 15"},
				{"en": "Psalm 118", "pt": "Salmo 118"},
				{"en": "Psalm 122", "pt": "Salmo 122"}
			]
		},
		{
			"question":
			{
				"en": "Which psalm begins, 'The Lord says to my Lord: Sit at my right hand'?",
				"pt": "Qual salmo começa: 'Disse o Senhor ao meu Senhor: Senta-te à minha direita'?"
			},
			"answer": {"en": "Psalm 110", "pt": "Salmo 110"},
			"tier": 3,
			"decoys":
			[
				{"en": "Psalm 2", "pt": "Salmo 2"},
				{"en": "Psalm 72", "pt": "Salmo 72"},
				{"en": "Psalm 45", "pt": "Salmo 45"}
			]
		},
		{
			"question":
			{
				"en":
				"Which psalm says, 'You are a priest forever, after the order of Melchizedek'?",
				"pt":
				"Qual salmo diz: 'Tu és sacerdote para sempre, segundo a ordem de Melquisedeque'?"
			},
			"answer": {"en": "Psalm 110", "pt": "Salmo 110"},
			"tier": 3,
			"decoys":
			[
				{"en": "Psalm 132", "pt": "Salmo 132"},
				{"en": "Psalm 89", "pt": "Salmo 89"},
				{"en": "Psalm 2", "pt": "Salmo 2"}
			]
		},
		{
			"question":
			{
				"en": "Which psalm urges praise with trumpet, harp, lyre, and cymbals?",
				"pt": "Qual salmo exorta louvor com trombeta, harpa, lira e címbalos?"
			},
			"answer": {"en": "Psalm 150", "pt": "Salmo 150"},
			"tier": 3,
			"decoys":
			[
				{"en": "Psalm 98", "pt": "Salmo 98"},
				{"en": "Psalm 33", "pt": "Salmo 33"},
				{"en": "Psalm 81", "pt": "Salmo 81"}
			]
		},
		{
			"question":
			{
				"en":
				"Which psalm warns that builders labor in vain unless the Lord builds the house?",
				"pt":
				"Qual salmo alerta que os construtores trabalham em vão se o Senhor não edificar a casa?"
			},
			"answer": {"en": "Psalm 127", "pt": "Salmo 127"},
			"tier": 2,
			"decoys":
			[
				{"en": "Psalm 126", "pt": "Salmo 126"},
				{"en": "Psalm 128", "pt": "Salmo 128"},
				{"en": "Psalm 133", "pt": "Salmo 133"}
			]
		}
	],
	"Proverbs & Wisdom":
	[
		{
			"question":
			{
				"en": "Who is credited with writing most proverbs?",
				"pt": "Quem é responsável por escrever a maioria dos provérbios?"
			},
			"answer": {"en": "Solomon", "pt": "Salomão"},
			"tier": 1,
			"decoys":
			[
				{"en": "David", "pt": "Davi"},
				{"en": "Hezekiah", "pt": "Ezequias"},
				{"en": "Agur", "pt": "Agur"}
			]
		},
		{
			"question":
			{"en": "What is the beginning of wisdom?", "pt": "Qual é o começo da sabedoria?"},
			"answer": {"en": "The fear of the Lord", "pt": "O temor do Senhor"},
			"tier": 1,
			"decoys":
			[
				{"en": "Knowledge of the law", "pt": "Conhecimento da lei"},
				{"en": "Obeying parents", "pt": "Obedecendo aos pais"},
				{"en": "Sacrifice", "pt": "Sacrifício"}
			]
		},
		{
			"question":
			{
				"en": "What small creature does Proverbs 6 say to consider?",
				"pt": "Que pequena criatura Provérbios 6 diz para considerarmos?"
			},
			"answer": {"en": "The ant", "pt": "A formiga"},
			"tier": 1,
			"decoys":
			[
				{"en": "The bee", "pt": "A abelha"},
				{"en": "The locust", "pt": "O gafanhoto"},
				{"en": "The spider", "pt": "A aranha"}
			]
		},
		{
			"question":
			{
				"en": "What turns away wrath according to Proverbs 15:1?",
				"pt": "O que afasta a ira de acordo com Provérbios 15:1?"
			},
			"answer": {"en": "A soft answer", "pt": "Uma resposta suave"},
			"tier": 1,
			"decoys":
			[
				{"en": "Silence", "pt": "Silêncio"},
				{"en": "A firm rebuke", "pt": "Uma repreensão firme"},
				{"en": "A loud retort", "pt": "Uma resposta alta"}
			]
		},
		{
			"question":
			{
				"en": "What does Proverbs 3:5 say to trust with all your heart?",
				"pt": "O que Provérbios 3:5 diz para confiar de todo o coração?"
			},
			"answer": {"en": "The Lord", "pt": "O Senhor"},
			"tier": 1,
			"decoys":
			[
				{"en": "Your own understanding", "pt": "Seu próprio entendimento"},
				{"en": "Princes", "pt": "Príncipes"},
				{"en": "Riches", "pt": "Riquezas"}
			]
		},
		{
			"question": {"en": "What does pride go before?", "pt": "O que vem antes do orgulho?"},
			"answer": {"en": "Destruction", "pt": "Destruição"},
			"tier": 1,
			"decoys":
			[
				{"en": "Honor", "pt": "Honra"},
				{"en": "Humility", "pt": "Humildade"},
				{"en": "Wisdom", "pt": "Sabedoria"}
			]
		},
		{
			"question":
			{
				"en": "What is sweeter than honey and more precious than gold?",
				"pt": "O que é mais doce que o mel e mais precioso que o ouro?"
			},
			"answer": {"en": "Wisdom", "pt": "Sabedoria"},
			"tier": 2,
			"decoys":
			[
				{"en": "Understanding", "pt": "Entendimento"},
				{"en": "Kind speech", "pt": "Discurso gentil"},
				{"en": "Knowledge", "pt": "Conhecimento"}
			]
		},
		{
			"question":
			{
				"en": "How are faithful wounds described?",
				"pt": "Como são descritas as feridas fiéis?"
			},
			"answer":
			{"en": "Faithful are the wounds of a friend", "pt": "Fiéis são as feridas de um amigo"},
			"tier": 2,
			"decoys":
			[
				{
					"en": "Painful are the wounds of the proud",
					"pt": "Dolorosas são as feridas dos orgulhosos"
				},
				{
					"en": "Blessed are the wounds of the humble",
					"pt": "Bem-aventuradas as feridas dos humildes"
				},
				{
					"en": "Healing are the words of a friend",
					"pt": "Cura são as palavras de um amigo"
				}
			]
		},
		{
			"question": {"en": "What does a wise son make?", "pt": "O que um filho sábio faz?"},
			"answer": {"en": "A glad father", "pt": "Um pai feliz"},
			"tier": 1,
			"decoys":
			[
				{"en": "A wealthy house", "pt": "Uma casa rica"},
				{"en": "A peaceful city", "pt": "Uma cidade pacífica"},
				{"en": "A proud mother", "pt": "Uma mãe orgulhosa"}
			]
		},
		{
			"question":
			{
				"en": "What is a soft tongue said to break?",
				"pt": "O que se diz que uma língua macia quebra?"
			},
			"answer": {"en": "A bone", "pt": "Um osso"},
			"tier": 2,
			"decoys":
			[
				{"en": "A shield", "pt": "Um escudo"},
				{"en": "Iron", "pt": "Ferro"},
				{"en": "The stout heart", "pt": "O coração robusto"}
			]
		},
		{
			"question":
			{
				"en": "Who was with the Lord at creation in Proverbs 8?",
				"pt": "Quem estava com o Senhor na criação em Provérbios 8?"
			},
			"answer": {"en": "Wisdom", "pt": "Sabedoria"},
			"tier": 2,
			"decoys":
			[
				{"en": "Understanding", "pt": "Entendimento"},
				{"en": "The angels", "pt": "Os anjos"},
				{"en": "The prophets", "pt": "Os profetas"}
			]
		},
		{
			"question":
			{
				"en": "What does a cheerful heart do according to Proverbs 17?",
				"pt": "O que faz um coração alegre de acordo com Provérbios 17?"
			},
			"answer": {"en": "Is good medicine", "pt": "É um bom remédio"},
			"tier": 1,
			"decoys":
			[
				{"en": "Glorifies God", "pt": "Glorifica a Deus"},
				{"en": "Wins friends", "pt": "Ganha amigos"},
				{"en": "Builds strength", "pt": "Constrói força"}
			]
		},
		{
			"question":
			{
				"en": "What does the righteous man fall and rise again?",
				"pt": "O que faz o justo cair e ressuscitar?"
			},
			"answer": {"en": "Seven times", "pt": "Sete vezes"},
			"tier": 2,
			"decoys":
			[
				{"en": "Three times", "pt": "Três vezes"},
				{"en": "Ten times", "pt": "Dez vezes"},
				{"en": "Twice", "pt": "Duas vezes"}
			]
		},
		{
			"question":
			{"en": "Who is better than the mighty?", "pt": "Quem é melhor que o poderoso?"},
			"answer": {"en": "He who rules his spirit", "pt": "Aquele que governa seu espírito"},
			"tier": 2,
			"decoys":
			[
				{"en": "He who gains wealth", "pt": "Aquele que ganha riqueza"},
				{"en": "He who commands armies", "pt": "Aquele que comanda exércitos"},
				{"en": "He who speaks wisely", "pt": "Aquele que fala com sabedoria"}
			]
		},
		{
			"question":
			{
				"en": "What is compared to apples of gold in settings of silver?",
				"pt": "O que é comparado às maçãs de ouro em engastes de prata?"
			},
			"answer": {"en": "A word fitly spoken", "pt": "Uma palavra dita apropriadamente"},
			"tier": 2,
			"decoys":
			[
				{"en": "A good name", "pt": "Um bom nome"},
				{"en": "A kind deed", "pt": "Uma ação gentil"},
				{"en": "A generous gift", "pt": "Um presente generoso"}
			]
		},
		{
			"question":
			{
				"en": "What crown do children's children give?",
				"pt": "Que coroa os filhos dos filhos dão?"
			},
			"answer": {"en": "A crown to the aged", "pt": "Uma coroa para os idosos"},
			"tier": 2,
			"decoys":
			[
				{"en": "A legacy of wealth", "pt": "Um legado de riqueza"},
				{"en": "Honor to kings", "pt": "Honra aos reis"},
				{"en": "Joy to the city", "pt": "Alegria para a cidade"}
			]
		},
		{
			"question":
			{
				"en": "What happens where there is no vision?",
				"pt": "O que acontece onde não há visão?"
			},
			"answer": {"en": "The people perish", "pt": "O povo perece"},
			"tier": 2,
			"decoys":
			[
				{"en": "The leaders fall", "pt": "Os líderes caem"},
				{"en": "The land withers", "pt": "A terra murcha"},
				{"en": "The house crumbles", "pt": "A casa desmorona"}
			]
		},
		{
			"question":
			{"en": "What is more precious than rubies?", "pt": "O que é mais precioso que rubis?"},
			"answer": {"en": "Wisdom", "pt": "Sabedoria"},
			"tier": 1,
			"decoys":
			[
				{"en": "Understanding", "pt": "Entendimento"},
				{"en": "Kindness", "pt": "Gentileza"},
				{"en": "Humility", "pt": "Humildade"}
			]
		},
		{
			"question":
			{
				"en": "What does a nagging spouse resemble?",
				"pt": "Qual é a aparência de um cônjuge irritante?"
			},
			"answer": {"en": "A constant dripping", "pt": "Um gotejamento constante"},
			"tier": 2,
			"decoys":
			[
				{"en": "A loud cymbal", "pt": "Um prato alto"},
				{"en": "A harsh wind", "pt": "Um vento forte"},
				{"en": "A broken wall", "pt": "Uma parede quebrada"}
			]
		},
		{
			"question":
			{"en": "What does a gentle answer do?", "pt": "O que uma resposta gentil faz?"},
			"answer": {"en": "Turns away wrath", "pt": "Afasta a ira"},
			"tier": 1,
			"decoys":
			[
				{"en": "Brings peace", "pt": "Traz paz"},
				{"en": "Shows humility", "pt": "Mostra humildade"},
				{"en": "Gains honor", "pt": "Ganha honra"}
			]
		},
		{
			"question":
			{
				"en": "Which proverb urges, 'Trust in the Lord with all your heart'?",
				"pt": "Qual provérbio exorta: 'Confia no Senhor de todo o teu coração'?"
			},
			"answer": {"en": "Proverbs 3:5", "pt": "Provérbios 3:5"},
			"tier": 3,
			"decoys":
			[
				{"en": "Proverbs 1:7", "pt": "Provérbios 1:7"},
				{"en": "Proverbs 16:3", "pt": "Provérbios 16:3"},
				{"en": "Proverbs 28:26", "pt": "Provérbios 28:26"}
			]
		},
		{
			"question":
			{
				"en": "Which proverb tells the sluggard to learn from the ant?",
				"pt": "Qual provérbio manda o preguiçoso aprender com a formiga?"
			},
			"answer": {"en": "Proverbs 6:6", "pt": "Provérbios 6:6"},
			"tier": 3,
			"decoys":
			[
				{"en": "Proverbs 24:30", "pt": "Provérbios 24:30"},
				{"en": "Proverbs 10:4", "pt": "Provérbios 10:4"},
				{"en": "Proverbs 19:15", "pt": "Provérbios 19:15"}
			]
		},
		{
			"question":
			{
				"en":
				"Which proverb warns, 'There is a way that seems right... but ends in death'?",
				"pt":
				"Qual provérbio alerta: 'Há caminho que ao homem parece direito... mas termina em morte'?"
			},
			"answer": {"en": "Proverbs 14:12", "pt": "Provérbios 14:12"},
			"tier": 3,
			"decoys":
			[
				{"en": "Proverbs 16:25", "pt": "Provérbios 16:25"},
				{"en": "Proverbs 3:7", "pt": "Provérbios 3:7"},
				{"en": "Proverbs 26:12", "pt": "Provérbios 26:12"}
			]
		},
		{
			"question":
			{
				"en": "Which proverb says, 'Iron sharpens iron, so one man sharpens another'?",
				"pt":
				"Qual provérbio diz: 'Assim como o ferro afia o ferro, o homem afia o seu companheiro'?"
			},
			"answer": {"en": "Proverbs 27:17", "pt": "Provérbios 27:17"},
			"tier": 3,
			"decoys":
			[
				{"en": "Proverbs 18:24", "pt": "Provérbios 18:24"},
				{"en": "Proverbs 20:5", "pt": "Provérbios 20:5"},
				{"en": "Proverbs 13:20", "pt": "Provérbios 13:20"}
			]
		},
		{
			"question":
			{
				"en": "Which proverb notes, 'Hope deferred makes the heart sick'?",
				"pt": "Qual provérbio afirma: 'A esperança adiada faz adoecer o coração'?"
			},
			"answer": {"en": "Proverbs 13:12", "pt": "Provérbios 13:12"},
			"tier": 3,
			"decoys":
			[
				{"en": "Proverbs 12:25", "pt": "Provérbios 12:25"},
				{"en": "Proverbs 18:14", "pt": "Provérbios 18:14"},
				{"en": "Proverbs 17:22", "pt": "Provérbios 17:22"}
			]
		},
		{
			"question":
			{
				"en": "Which proverb says, 'A cheerful heart is good medicine'?",
				"pt": "Qual provérbio diz: 'O coração alegre é bom remédio'?"
			},
			"answer": {"en": "Proverbs 17:22", "pt": "Provérbios 17:22"},
			"tier": 3,
			"decoys":
			[
				{"en": "Proverbs 15:13", "pt": "Provérbios 15:13"},
				{"en": "Proverbs 12:25", "pt": "Provérbios 12:25"},
				{"en": "Proverbs 16:24", "pt": "Provérbios 16:24"}
			]
		},
		{
			"question":
			{
				"en": "Which proverb contrasts a dry crust with peace versus feasting with strife?",
				"pt":
				"Qual provérbio contrasta uma crosta seca com paz versus banquete com contenda?"
			},
			"answer": {"en": "Proverbs 17:1", "pt": "Provérbios 17:1"},
			"tier": 3,
			"decoys":
			[
				{"en": "Proverbs 15:17", "pt": "Provérbios 15:17"},
				{"en": "Proverbs 21:9", "pt": "Provérbios 21:9"},
				{"en": "Proverbs 21:19", "pt": "Provérbios 21:19"}
			]
		},
		{
			"question":
			{
				"en": "Which proverb begins, 'The fear of the Lord is the beginning of knowledge'?",
				"pt": "Qual provérbio começa: 'O temor do Senhor é o princípio do conhecimento'?"
			},
			"answer": {"en": "Proverbs 1:7", "pt": "Provérbios 1:7"},
			"tier": 3,
			"decoys":
			[
				{"en": "Proverbs 9:10", "pt": "Provérbios 9:10"},
				{"en": "Proverbs 10:27", "pt": "Provérbios 10:27"},
				{"en": "Proverbs 3:7", "pt": "Provérbios 3:7"}
			]
		},
		{
			"question":
			{
				"en": "Which chapter describes the noble wife whose worth is far above rubies?",
				"pt": "Qual capítulo descreve a esposa virtuosa cujo valor excede os rubis?"
			},
			"answer": {"en": "Proverbs 31", "pt": "Provérbios 31"},
			"tier": 3,
			"decoys":
			[
				{"en": "Proverbs 30", "pt": "Provérbios 30"},
				{"en": "Proverbs 18", "pt": "Provérbios 18"},
				{"en": "Proverbs 12", "pt": "Provérbios 12"}
			]
		},
		{
			"question":
			{
				"en":
				"Which proverb says, 'Better a little with righteousness than great revenues with injustice'?",
				"pt":
				"Qual provérbio diz: 'Melhor é o pouco com justiça do que grandes rendas com injustiça'?"
			},
			"answer": {"en": "Proverbs 16:8", "pt": "Provérbios 16:8"},
			"tier": 3,
			"decoys":
			[
				{"en": "Proverbs 15:16", "pt": "Provérbios 15:16"},
				{"en": "Proverbs 11:4", "pt": "Provérbios 11:4"},
				{"en": "Proverbs 22:1", "pt": "Provérbios 22:1"}
			]
		}
	],
	"Major Prophets":
	[
		{
			"question":
			{
				"en": "Which prophet saw the Lord in the temple and cried 'Here am I'?",
				"pt": "Qual profeta viu o Senhor no templo e gritou: “Eis-me aqui”?"
			},
			"answer": {"en": "Isaiah", "pt": "Isaías"},
			"tier": 1,
			"decoys":
			[
				{"en": "Jeremiah", "pt": "Jeremias"},
				{"en": "Ezekiel", "pt": "Ezequiel"},
				{"en": "Daniel", "pt": "Danilo"}
			]
		},
		{
			"question":
			{"en": "Who is called the weeping prophet?", "pt": "Quem é chamado de profeta chorão?"},
			"answer": {"en": "Jeremiah", "pt": "Jeremias"},
			"tier": 1,
			"decoys":
			[
				{"en": "Ezekiel", "pt": "Ezequiel"},
				{"en": "Isaiah", "pt": "Isaías"},
				{"en": "Amos", "pt": "Amós"}
			]
		},
		{
			"question":
			{
				"en": "Whose vision included dry bones coming to life?",
				"pt": "A visão de quem incluía ossos secos ganhando vida?"
			},
			"answer": {"en": "Ezekiel", "pt": "Ezequiel"},
			"tier": 2,
			"decoys":
			[
				{"en": "Daniel", "pt": "Danilo"},
				{"en": "Zechariah", "pt": "Zacarias"},
				{"en": "Hosea", "pt": "Oséias"}
			]
		},
		{
			"question":
			{
				"en": "Who interpreted the handwriting on the wall for King Belshazzar?",
				"pt": "Quem interpretou a escrita na parede para o rei Belsazar?"
			},
			"answer": {"en": "Daniel", "pt": "Danilo"},
			"tier": 1,
			"decoys":
			[
				{"en": "Ezekiel", "pt": "Ezequiel"},
				{"en": "Joseph", "pt": "José"},
				{"en": "Nehemiah", "pt": "Neemias"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet wrote about the suffering servant?",
				"pt": "Qual profeta escreveu sobre o servo sofredor?"
			},
			"answer": {"en": "Isaiah", "pt": "Isaías"},
			"tier": 2,
			"decoys":
			[
				{"en": "Jeremiah", "pt": "Jeremias"},
				{"en": "Zechariah", "pt": "Zacarias"},
				{"en": "Micah", "pt": "Miquéias"}
			]
		},
		{
			"question":
			{
				"en": "Who saw a burning coal touch his lips?",
				"pt": "Quem viu uma brasa tocar seus lábios?"
			},
			"answer": {"en": "Isaiah", "pt": "Isaías"},
			"tier": 2,
			"decoys":
			[
				{"en": "Jeremiah", "pt": "Jeremias"},
				{"en": "Ezekiel", "pt": "Ezequiel"},
				{"en": "Daniel", "pt": "Danilo"}
			]
		},
		{
			"question":
			{
				"en": "Who bought a field as a sign during siege?",
				"pt": "Quem comprou um campo como sinal durante o cerco?"
			},
			"answer": {"en": "Jeremiah", "pt": "Jeremias"},
			"tier": 2,
			"decoys":
			[
				{"en": "Isaiah", "pt": "Isaías"},
				{"en": "Ezekiel", "pt": "Ezequiel"},
				{"en": "Nehemiah", "pt": "Neemias"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet lay on his side to bear Israel's sin?",
				"pt": "Qual profeta se deitou ao seu lado para carregar o pecado de Israel?"
			},
			"answer": {"en": "Ezekiel", "pt": "Ezequiel"},
			"tier": 3,
			"decoys":
			[
				{"en": "Hosea", "pt": "Oséias"},
				{"en": "Isaiah", "pt": "Isaías"},
				{"en": "Jeremiah", "pt": "Jeremias"}
			]
		},
		{
			"question":
			{
				"en": "Who saw a man in linen with a writing kit?",
				"pt": "Quem viu um homem vestido de linho com um estojo de escrita?"
			},
			"answer": {"en": "Ezekiel", "pt": "Ezequiel"},
			"tier": 3,
			"decoys":
			[
				{"en": "Daniel", "pt": "Danilo"},
				{"en": "Zechariah", "pt": "Zacarias"},
				{"en": "Jeremiah", "pt": "Jeremias"}
			]
		},
		{
			"question":
			{
				"en": "Whose book has the statue of gold, silver, bronze, iron, clay?",
				"pt": "De quem é o livro que contém a estátua de ouro, prata, bronze, ferro, barro?"
			},
			"answer": {"en": "Daniel", "pt": "Danilo"},
			"tier": 1,
			"decoys":
			[
				{"en": "Ezekiel", "pt": "Ezequiel"},
				{"en": "Jeremiah", "pt": "Jeremias"},
				{"en": "Isaiah", "pt": "Isaías"}
			]
		},
		{
			"question":
			{
				"en": "Who saw beasts rise from the sea symbolizing kingdoms?",
				"pt": "Quem viu feras surgirem do mar simbolizando reinos?"
			},
			"answer": {"en": "Daniel", "pt": "Danilo"},
			"tier": 2,
			"decoys":
			[
				{"en": "Ezekiel", "pt": "Ezequiel"},
				{"en": "Zechariah", "pt": "Zacarias"},
				{"en": "Revelation's John", "pt": "João do Apocalipse"}
			]
		},
		{
			"question":
			{
				"en": "Who prophesied about the New Covenant written on hearts?",
				"pt": "Quem profetizou sobre a Nova Aliança escrita nos corações?"
			},
			"answer": {"en": "Jeremiah", "pt": "Jeremias"},
			"tier": 2,
			"decoys":
			[
				{"en": "Isaiah", "pt": "Isaías"},
				{"en": "Ezekiel", "pt": "Ezequiel"},
				{"en": "Hosea", "pt": "Oséias"}
			]
		},
		{
			"question":
			{
				"en": "Who saw a wheel within a wheel?",
				"pt": "Quem viu uma roda dentro de outra roda?"
			},
			"answer": {"en": "Ezekiel", "pt": "Ezequiel"},
			"tier": 2,
			"decoys":
			[
				{"en": "Daniel", "pt": "Danilo"},
				{"en": "Zechariah", "pt": "Zacarias"},
				{"en": "John", "pt": "John"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet was taken to Babylon as a youth?",
				"pt": "Qual profeta foi levado para a Babilônia quando jovem?"
			},
			"answer": {"en": "Daniel", "pt": "Danilo"},
			"tier": 2,
			"decoys":
			[
				{"en": "Ezekiel", "pt": "Ezequiel"},
				{"en": "Jeremiah", "pt": "Jeremias"},
				{"en": "Nehemiah", "pt": "Neemias"}
			]
		},
		{
			"question":
			{
				"en": "Who saw the valley of vision about Judah's downfall?",
				"pt": "Quem viu o vale da visão sobre a queda de Judá?"
			},
			"answer": {"en": "Isaiah", "pt": "Isaías"},
			"tier": 3,
			"decoys":
			[
				{"en": "Jeremiah", "pt": "Jeremias"},
				{"en": "Ezekiel", "pt": "Ezequiel"},
				{"en": "Habakkuk", "pt": "Habacuque"}
			]
		},
		{
			"question":
			{
				"en": "Who was told to eat a scroll that tasted sweet?",
				"pt": "A quem foi dito para comer um pergaminho de sabor doce?"
			},
			"answer": {"en": "Ezekiel", "pt": "Ezequiel"},
			"tier": 1,
			"decoys":
			[
				{"en": "John", "pt": "John"},
				{"en": "Isaiah", "pt": "Isaías"},
				{"en": "Daniel", "pt": "Danilo"}
			]
		},
		{
			"question":
			{
				"en": "Who prophesied Cyrus by name as God's shepherd?",
				"pt": "Quem profetizou o nome de Ciro como pastor de Deus?"
			},
			"answer": {"en": "Isaiah", "pt": "Isaías"},
			"tier": 3,
			"decoys":
			[
				{"en": "Jeremiah", "pt": "Jeremias"},
				{"en": "Ezekiel", "pt": "Ezequiel"},
				{"en": "Haggai", "pt": "Ageu"}
			]
		},
		{
			"question":
			{
				"en": "Who had visions by the Kebar River?",
				"pt": "Quem teve visões junto ao rio Kebar?"
			},
			"answer": {"en": "Ezekiel", "pt": "Ezequiel"},
			"tier": 2,
			"decoys":
			[
				{"en": "Daniel", "pt": "Danilo"},
				{"en": "Jeremiah", "pt": "Jeremias"},
				{"en": "Nehemiah", "pt": "Neemias"}
			]
		},
		{
			"question":
			{
				"en": "Who prayed three times a day facing Jerusalem?",
				"pt": "Quem orava três vezes ao dia voltado para Jerusalém?"
			},
			"answer": {"en": "Daniel", "pt": "Danilo"},
			"tier": 1,
			"decoys":
			[
				{"en": "Ezra", "pt": "Esdras"},
				{"en": "Nehemiah", "pt": "Neemias"},
				{"en": "Mordecai", "pt": "Mordecai"}
			]
		},
		{
			"question":
			{
				"en": "Who saw the Ancient of Days sit in judgment?",
				"pt": "Quem viu o Ancião de Dias julgar?"
			},
			"answer": {"en": "Daniel", "pt": "Danilo"},
			"tier": 2,
			"decoys":
			[
				{"en": "Ezekiel", "pt": "Ezequiel"},
				{"en": "Isaiah", "pt": "Isaías"},
				{"en": "John in Revelation", "pt": "João no Apocalipse"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet spent a night in a den of lions?",
				"pt": "Qual profeta passou uma noite na cova dos le?es?"
			},
			"answer": {"en": "Daniel", "pt": "Daniel"},
			"tier": 1,
			"decoys":
			[
				{"en": "Jeremiah", "pt": "Jeremias"},
				{"en": "Ezekiel", "pt": "Ezequiel"},
				{"en": "Isaiah", "pt": "Isa?as"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet wrote a book of laments over Jerusalem's fall?",
				"pt": "Qual profeta escreveu um livro de lamenta??es sobre a queda de Jerusal?m?"
			},
			"answer": {"en": "Jeremiah", "pt": "Jeremias"},
			"tier": 1,
			"decoys":
			[
				{"en": "Isaiah", "pt": "Isa?as"},
				{"en": "Ezekiel", "pt": "Ezequiel"},
				{"en": "Daniel", "pt": "Daniel"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet was told a virgin would conceive a son called Immanuel?",
				"pt": "Qual profeta ouviu que uma virgem conceberia um filho chamado Emanuel?"
			},
			"answer": {"en": "Isaiah", "pt": "Isa?as"},
			"tier": 1,
			"decoys":
			[
				{"en": "Jeremiah", "pt": "Jeremias"},
				{"en": "Ezekiel", "pt": "Ezequiel"},
				{"en": "Malachi", "pt": "Malaquias"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet lived among the exiles by the Kebar River?",
				"pt": "Qual profeta viveu entre os exilados ? beira do rio Quebar?"
			},
			"answer": {"en": "Ezekiel", "pt": "Ezequiel"},
			"tier": 1,
			"decoys":
			[
				{"en": "Isaiah", "pt": "Isa?as"},
				{"en": "Habakkuk", "pt": "Habacuque"},
				{"en": "Haggai", "pt": "Ageu"}
			]
		},
		{
			"question":
			{
				"en":
				"Which chapter foretells the Suffering Servant pierced for our transgressions?",
				"pt": "Qual cap?tulo prediz o Servo Sofredor traspassado por nossas transgress?es?"
			},
			"answer": {"en": "Isaiah 53", "pt": "Isa?as 53"},
			"tier": 3,
			"decoys":
			[
				{"en": "Isaiah 7", "pt": "Isa?as 7"},
				{"en": "Jeremiah 31", "pt": "Jeremias 31"},
				{"en": "Ezekiel 18", "pt": "Ezequiel 18"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet buried a linen belt near the Euphrates as a sign?",
				"pt": "Qual profeta enterrou um cinto de linho perto do Eufrates como sinal?"
			},
			"answer": {"en": "Jeremiah", "pt": "Jeremias"},
			"tier": 3,
			"decoys":
			[
				{"en": "Isaiah", "pt": "Isa?as"},
				{"en": "Ezekiel", "pt": "Ezequiel"},
				{"en": "Amos", "pt": "Am?s"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet saw a boiling pot tilting from the north?",
				"pt": "Qual profeta viu uma panela fervendo inclinada do norte?"
			},
			"answer": {"en": "Jeremiah", "pt": "Jeremias"},
			"tier": 3,
			"decoys":
			[
				{"en": "Ezekiel", "pt": "Ezequiel"},
				{"en": "Habakkuk", "pt": "Habacuque"},
				{"en": "Daniel", "pt": "Daniel"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet cooked food over cow dung after protesting using human dung?",
				"pt":
				"Qual profeta cozinhou comida sobre esterco de vaca ap?s protestar usar esterco humano?"
			},
			"answer": {"en": "Ezekiel", "pt": "Ezequiel"},
			"tier": 3,
			"decoys":
			[
				{"en": "Jeremiah", "pt": "Jeremias"},
				{"en": "Amos", "pt": "Am?s"},
				{"en": "Malachi", "pt": "Malaquias"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet saw a ram and a goat colliding by the Ulai Canal?",
				"pt": "Qual profeta viu um carneiro e um bode colidindo junto ao rio Ulai?"
			},
			"answer": {"en": "Daniel", "pt": "Daniel"},
			"tier": 3,
			"decoys":
			[
				{"en": "Isaiah", "pt": "Isa?as"},
				{"en": "Jeremiah", "pt": "Jeremias"},
				{"en": "Ezekiel", "pt": "Ezequiel"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet received the prophecy of seventy weeks concerning his people?",
				"pt": "Qual profeta recebeu a profecia das setenta semanas para seu povo?"
			},
			"answer": {"en": "Daniel", "pt": "Daniel"},
			"tier": 3,
			"decoys":
			[
				{"en": "Jeremiah", "pt": "Jeremias"},
				{"en": "Ezekiel", "pt": "Ezequiel"},
				{"en": "Haggai", "pt": "Ageu"}
			]
		}
	],
	"Minor Prophets":
	[
		{
			"question":
			{
				"en": "Which prophet was swallowed by a great fish?",
				"pt": "Qual profeta foi engolido por um grande peixe?"
			},
			"answer": {"en": "Jonah", "pt": "Jonas"},
			"tier": 1,
			"decoys":
			[
				{"en": "Micah", "pt": "Miquéias"},
				{"en": "Nahum", "pt": "Naum"},
				{"en": "Amos", "pt": "Amós"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet foretold Bethlehem as Messiah's birthplace?",
				"pt": "Qual profeta predisse Belém como o local de nascimento do Messias?"
			},
			"answer": {"en": "Micah", "pt": "Miquéias"},
			"tier": 1,
			"decoys":
			[
				{"en": "Hosea", "pt": "Oséias"},
				{"en": "Zechariah", "pt": "Zacarias"},
				{"en": "Malachi", "pt": "Malaquias"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet married Gomer as a sign to Israel?",
				"pt": "Qual profeta se casou com Gômer como um sinal para Israel?"
			},
			"answer": {"en": "Hosea", "pt": "Oséias"},
			"tier": 2,
			"decoys":
			[
				{"en": "Amos", "pt": "Amós"},
				{"en": "Joel", "pt": "Joel"},
				{"en": "Zephaniah", "pt": "Sofonias"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet was a shepherd from Tekoa?",
				"pt": "Qual profeta era pastor de Tekoa?"
			},
			"answer": {"en": "Amos", "pt": "Amós"},
			"tier": 2,
			"decoys":
			[
				{"en": "Nahum", "pt": "Naum"},
				{"en": "Haggai", "pt": "Ageu"},
				{"en": "Obadiah", "pt": "Obadias"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet spoke of a messenger preparing the way?",
				"pt": "Qual profeta falou de um mensageiro preparando o caminho?"
			},
			"answer": {"en": "Malachi", "pt": "Malaquias"},
			"tier": 1,
			"decoys":
			[
				{"en": "Zechariah", "pt": "Zacarias"},
				{"en": "Haggai", "pt": "Ageu"},
				{"en": "Joel", "pt": "Joel"}
			]
		},
		{
			"question":
			{
				"en": "Who saw a plumb line in a vision?",
				"pt": "Quem viu um fio de prumo em uma visão?"
			},
			"answer": {"en": "Amos", "pt": "Amós"},
			"tier": 3,
			"decoys":
			[
				{"en": "Zechariah", "pt": "Zacarias"},
				{"en": "Haggai", "pt": "Ageu"},
				{"en": "Habakkuk", "pt": "Habacuque"}
			]
		},
		{
			"question":
			{
				"en": "Who had a vision of a flying scroll?",
				"pt": "Quem teve a visão de um pergaminho voador?"
			},
			"answer": {"en": "Zechariah", "pt": "Zacarias"},
			"tier": 3,
			"decoys":
			[
				{"en": "Habakkuk", "pt": "Habacuque"},
				{"en": "Malachi", "pt": "Malaquias"},
				{"en": "Joel", "pt": "Joel"}
			]
		},
		{
			"question":
			{
				"en": "Who preached to Nineveh before its fall?",
				"pt": "Quem pregou em Nínive antes da sua queda?"
			},
			"answer": {"en": "Nahum", "pt": "Naum"},
			"tier": 2,
			"decoys":
			[
				{"en": "Jonah", "pt": "Jonas"},
				{"en": "Obadiah", "pt": "Obadias"},
				{"en": "Micah", "pt": "Miquéias"}
			]
		},
		{
			"question":
			{
				"en": "Who urged the people, 'Return to me and I will return to you'?",
				"pt": "Quem exortou o povo: ‘Voltem para mim e eu voltarei para vocês’?"
			},
			"answer": {"en": "Malachi", "pt": "Malaquias"},
			"tier": 1,
			"decoys":
			[
				{"en": "Zechariah", "pt": "Zacarias"},
				{"en": "Haggai", "pt": "Ageu"},
				{"en": "Joel", "pt": "Joel"}
			]
		},
		{
			"question":
			{
				"en": "Who saw the Lord on his holy temple and said the righteous live by faith?",
				"pt": "Quem viu o Senhor em seu templo sagrado e disse que os justos vivem pela fé?"
			},
			"answer": {"en": "Habakkuk", "pt": "Habacuque"},
			"tier": 2,
			"decoys":
			[
				{"en": "Zephaniah", "pt": "Sofonias"},
				{"en": "Haggai", "pt": "Ageu"},
				{"en": "Micah", "pt": "Miquéias"}
			]
		},
		{
			"question":
			{
				"en": "Who described the Day of the Lord with locust armies?",
				"pt": "Quem descreveu o Dia do Senhor com exércitos de gafanhotos?"
			},
			"answer": {"en": "Joel", "pt": "Joel"},
			"tier": 2,
			"decoys":
			[
				{"en": "Nahum", "pt": "Naum"},
				{"en": "Obadiah", "pt": "Obadias"},
				{"en": "Zephaniah", "pt": "Sofonias"}
			]
		},
		{
			"question":
			{
				"en": "Who prophesied against Edom for violence against Jacob?",
				"pt": "Quem profetizou contra Edom por causa da violência contra Jacó?"
			},
			"answer": {"en": "Obadiah", "pt": "Obadias"},
			"tier": 2,
			"decoys":
			[
				{"en": "Nahum", "pt": "Naum"},
				{"en": "Micah", "pt": "Miquéias"},
				{"en": "Joel", "pt": "Joel"}
			]
		},
		{
			"question":
			{
				"en": "Whose name means 'festival' and encouraged temple rebuilding?",
				"pt": "Cujo nome significa 'festival' e incentivou a reconstrução do templo?"
			},
			"answer": {"en": "Haggai", "pt": "Ageu"},
			"tier": 2,
			"decoys":
			[
				{"en": "Zechariah", "pt": "Zacarias"},
				{"en": "Malachi", "pt": "Malaquias"},
				{"en": "Habakkuk", "pt": "Habacuque"}
			]
		},
		{
			"question":
			{
				"en": "Who wrote about a remnant who seek the Lord, meek and humble?",
				"pt": "Quem escreveu sobre um remanescente que busca ao Senhor, manso e humilde?"
			},
			"answer": {"en": "Zephaniah", "pt": "Sofonias"},
			"tier": 3,
			"decoys":
			[
				{"en": "Micah", "pt": "Miquéias"},
				{"en": "Habakkuk", "pt": "Habacuque"},
				{"en": "Amos", "pt": "Amós"}
			]
		},
		{
			"question":
			{
				"en": "Who warned that swarms of locusts were like an army?",
				"pt": "Quem avisou que enxames de gafanhotos eram como um exército?"
			},
			"answer": {"en": "Joel", "pt": "Joel"},
			"tier": 2,
			"decoys":
			[
				{"en": "Nahum", "pt": "Naum"},
				{"en": "Malachi", "pt": "Malaquias"},
				{"en": "Haggai", "pt": "Ageu"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet saw a vision of Joshua the high priest before the Angel?",
				"pt": "Qual profeta teve uma visão de Josué, o sumo sacerdote, diante do Anjo?"
			},
			"answer": {"en": "Zechariah", "pt": "Zacarias"},
			"tier": 3,
			"decoys":
			[
				{"en": "Haggai", "pt": "Ageu"},
				{"en": "Malachi", "pt": "Malaquias"},
				{"en": "Habakkuk", "pt": "Habacuque"}
			]
		},
		{
			"question":
			{
				"en": "Who was called to love an unfaithful wife as a sign?",
				"pt": "Quem foi chamado a amar como sinal uma esposa infiel?"
			},
			"answer": {"en": "Hosea", "pt": "Oséias"},
			"tier": 2,
			"decoys":
			[
				{"en": "Jeremiah", "pt": "Jeremias"},
				{"en": "Amos", "pt": "Amós"},
				{"en": "Micah", "pt": "Miquéias"}
			]
		},
		{
			"question":
			{
				"en": "Who foretold a ruler from Bethlehem whose origins are from ancient times?",
				"pt":
				"Quem predisse um governante de Belém cujas origens remontam aos tempos antigos?"
			},
			"answer": {"en": "Micah", "pt": "Miquéias"},
			"tier": 2,
			"decoys":
			[
				{"en": "Zechariah", "pt": "Zacarias"},
				{"en": "Hosea", "pt": "Oséias"},
				{"en": "Amos", "pt": "Amós"}
			]
		},
		{
			"question":
			{
				"en": "Who saw visions at night including four horns and four craftsmen?",
				"pt": "Quem teve visões noturnas incluindo quatro chifres e quatro artesãos?"
			},
			"answer": {"en": "Zechariah", "pt": "Zacarias"},
			"tier": 3,
			"decoys":
			[
				{"en": "Haggai", "pt": "Ageu"},
				{"en": "Habakkuk", "pt": "Habacuque"},
				{"en": "Obadiah", "pt": "Obadias"}
			]
		},
		{
			"question":
			{
				"en": "Who vowed, 'As for me and my house, we will serve the Lord'?",
				"pt": "Quem jurou: 'Quanto a mim e à minha casa serviremos ao Senhor'?"
			},
			"answer": {"en": "Joshua", "pt": "Josué"},
			"tier": 1,
			"decoys":
			[
				{"en": "Caleb", "pt": "Calebe"},
				{"en": "Samuel", "pt": "Samuel"},
				{"en": "Gideon", "pt": "Gideão"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet called the returned exiles to rebuild the temple?",
				"pt": "Qual profeta chamou os exilados que voltaram para reconstruir o templo?"
			},
			"answer": {"en": "Haggai", "pt": "Ageu"},
			"tier": 1,
			"decoys":
			[
				{"en": "Zechariah", "pt": "Zacarias"},
				{"en": "Malachi", "pt": "Malaquias"},
				{"en": "Ezra", "pt": "Esdras"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet declared, 'Not by might nor by power, but by my Spirit'?",
				"pt": "Qual profeta declarou: 'N?o por for?a nem por poder, mas pelo meu Esp?rito'?"
			},
			"answer": {"en": "Zechariah", "pt": "Zacarias"},
			"tier": 1,
			"decoys":
			[
				{"en": "Haggai", "pt": "Ageu"},
				{"en": "Malachi", "pt": "Malaquias"},
				{"en": "Joel", "pt": "Joel"}
			]
		},
		{
			"question":
			{
				"en":
				"Which prophet ran from Nineveh's call and later sat under a plant east of the city?",
				"pt":
				"Qual profeta fugiu do chamado a N?nive e depois se sentou sob uma planta a leste da cidade?"
			},
			"answer": {"en": "Jonah", "pt": "Jonas"},
			"tier": 1,
			"decoys":
			[
				{"en": "Nahum", "pt": "Naum"},
				{"en": "Habakkuk", "pt": "Habacuque"},
				{"en": "Micah", "pt": "Miqueias"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet focused his entire book on judgment against Edom?",
				"pt": "Qual profeta concentrou seu livro inteiro em ju?zo contra Edom?"
			},
			"answer": {"en": "Obadiah", "pt": "Obadias"},
			"tier": 1,
			"decoys":
			[
				{"en": "Joel", "pt": "Joel"},
				{"en": "Amos", "pt": "Am?s"},
				{"en": "Malachi", "pt": "Malaquias"}
			]
		},
		{
			"question":
			{
				"en":
				"Which prophet promised Elijah would come before the great and terrible day of the Lord?",
				"pt":
				"Qual profeta prometeu que Elias viria antes do grande e terr?vel dia do Senhor?"
			},
			"answer": {"en": "Malachi", "pt": "Malaquias"},
			"tier": 1,
			"decoys":
			[
				{"en": "Haggai", "pt": "Ageu"},
				{"en": "Zephaniah", "pt": "Sofonias"},
				{"en": "Zechariah", "pt": "Zacarias"}
			]
		},
		{
			"question":
			{
				"en":
				"Which prophet saw a basket of summer fruit showing Israel was ripe for judgment?",
				"pt":
				"Qual profeta viu um cesto de frutas de ver?o mostrando que Israel estava maduro para o ju?zo?"
			},
			"answer": {"en": "Amos", "pt": "Am?s"},
			"tier": 3,
			"decoys":
			[
				{"en": "Hosea", "pt": "Os?ias"},
				{"en": "Joel", "pt": "Joel"},
				{"en": "Micah", "pt": "Miqueias"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet named his children Lo-Ruhamah and Lo-Ammi as signs?",
				"pt": "Qual profeta nomeou seus filhos Lo-Ruama e Lo-Ami como sinais?"
			},
			"answer": {"en": "Hosea", "pt": "Os?ias"},
			"tier": 3,
			"decoys":
			[
				{"en": "Micah", "pt": "Miqueias"},
				{"en": "Zechariah", "pt": "Zacarias"},
				{"en": "Habakkuk", "pt": "Habacuque"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet said the Lord would rejoice over Zion with singing?",
				"pt": "Qual profeta disse que o Senhor se alegraria em Si?o com c?nticos?"
			},
			"answer": {"en": "Zephaniah", "pt": "Sofonias"},
			"tier": 3,
			"decoys":
			[
				{"en": "Haggai", "pt": "Ageu"},
				{"en": "Joel", "pt": "Joel"},
				{"en": "Malachi", "pt": "Malaquias"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet pictured chariots racing through Nineveh's streets?",
				"pt": "Qual profeta descreveu carros correndo pelas ruas de N?nive?"
			},
			"answer": {"en": "Nahum", "pt": "Naum"},
			"tier": 3,
			"decoys":
			[
				{"en": "Jonah", "pt": "Jonas"},
				{"en": "Habakkuk", "pt": "Habacuque"},
				{"en": "Zechariah", "pt": "Zacarias"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet climbed a watchtower to wait for God's answer?",
				"pt": "Qual profeta subiu a uma torre de vigia para aguardar a resposta de Deus?"
			},
			"answer": {"en": "Habakkuk", "pt": "Habacuque"},
			"tier": 3,
			"decoys":
			[
				{"en": "Haggai", "pt": "Ageu"},
				{"en": "Micah", "pt": "Miqueias"},
				{"en": "Malachi", "pt": "Malaquias"}
			]
		}
	],
	"Women of the Old Testament":
	[
		{
			"question":
			{"en": "Who gleaned in Boaz's field?", "pt": "Quem recolheu no campo de Boaz?"},
			"answer": {"en": "Ruth", "pt": "Rute"},
			"tier": 1,
			"decoys":
			[
				{"en": "Orpah", "pt": "Orfa"},
				{"en": "Naomi", "pt": "Noemi"},
				{"en": "Tamar", "pt": "Tamar"}
			]
		},
		{
			"question":
			{
				"en": "Which queen saved her people from Haman?",
				"pt": "Qual rainha salvou seu povo de Haman?"
			},
			"answer": {"en": "Esther", "pt": "Ester"},
			"tier": 1,
			"decoys":
			[
				{"en": "Vashti", "pt": "Vasti"},
				{"en": "Athaliah", "pt": "Atalia"},
				{"en": "Bathsheba", "pt": "Bate-Seba"}
			]
		},
		{
			"question": {"en": "Who was Abraham's wife?", "pt": "Quem era a esposa de Abraao?"},
			"answer": {"en": "Sarah", "pt": "Sara"},
			"tier": 1,
			"decoys":
			[
				{"en": "Hagar", "pt": "Agar"},
				{"en": "Keturah", "pt": "Quetura"},
				{"en": "Rebekah", "pt": "Rebeca"}
			]
		},
		{
			"question": {"en": "Who was Isaac's wife?", "pt": "Quem era a esposa de Isaque?"},
			"answer": {"en": "Rebekah", "pt": "Rebeca"},
			"tier": 1,
			"decoys":
			[
				{"en": "Rachel", "pt": "Raquel"},
				{"en": "Leah", "pt": "Lia"},
				{"en": "Sarah", "pt": "Sara"}
			]
		},
		{
			"question":
			{"en": "Who was Jacob's beloved wife?", "pt": "Quem era a esposa amada de Jaco?"},
			"answer": {"en": "Rachel", "pt": "Raquel"},
			"tier": 1,
			"decoys":
			[
				{"en": "Leah", "pt": "Lia"},
				{"en": "Bilhah", "pt": "Bila"},
				{"en": "Zilpah", "pt": "Zilpa"}
			]
		},
		{
			"question":
			{
				"en": "Who prayed for a son and bore Samuel?",
				"pt": "Quem orou por um filho e gerou Samuel?"
			},
			"answer": {"en": "Hannah", "pt": "Ana"},
			"tier": 1,
			"decoys":
			[
				{"en": "Elizabeth", "pt": "Elisabete"},
				{"en": "Naomi", "pt": "Noemi"},
				{"en": "Deborah", "pt": "Debora"}
			]
		},
		{
			"question":
			{
				"en": "Who hid the Hebrew spies on her roof?",
				"pt": "Quem escondeu os espioes hebreus no telhado?"
			},
			"answer": {"en": "Rahab", "pt": "Raabe"},
			"tier": 1,
			"decoys":
			[
				{"en": "Ruth", "pt": "Rute"},
				{"en": "Jael", "pt": "Jael"},
				{"en": "Huldah", "pt": "Hulda"}
			]
		},
		{
			"question":
			{
				"en": "Who was the sister of Moses and Aaron?",
				"pt": "Quem era a irma de Moises e Aarao?"
			},
			"answer": {"en": "Miriam", "pt": "Miri?"},
			"tier": 1,
			"decoys":
			[
				{"en": "Zipporah", "pt": "Zipora"},
				{"en": "Jochebed", "pt": "Joquebede"},
				{"en": "Deborah", "pt": "Debora"}
			]
		},
		{
			"question":
			{
				"en": "Who was the wife of Uriah and mother of Solomon?",
				"pt": "Quem foi a esposa de Urias e mae de Salomao?"
			},
			"answer": {"en": "Bathsheba", "pt": "Bate-Seba"},
			"tier": 1,
			"decoys":
			[
				{"en": "Michal", "pt": "Mical"},
				{"en": "Abigail", "pt": "Abigail"},
				{"en": "Tamar", "pt": "Tamar"}
			]
		},
		{
			"question": {"en": "Who was Ruth's mother-in-law?", "pt": "Quem era a sogra de Rute?"},
			"answer": {"en": "Naomi", "pt": "Noemi"},
			"tier": 1,
			"decoys":
			[
				{"en": "Orpah", "pt": "Orfa"},
				{"en": "Mara", "pt": "Mara"},
				{"en": "Milcah", "pt": "Milca"}
			]
		},
		{
			"question":
			{
				"en": "Who confronted David to prevent him from avenging himself on Nabal?",
				"pt": "Quem confrontou Davi para impedi-lo de vingar-se de Nabal?"
			},
			"answer": {"en": "Abigail", "pt": "Abigail"},
			"tier": 2,
			"decoys":
			[
				{"en": "Michal", "pt": "Mical"},
				{"en": "Bathsheba", "pt": "Bate-Seba"},
				{"en": "Tamar", "pt": "Tamar"}
			]
		},
		{
			"question":
			{
				"en": "Which prophetess verified the Book of the Law in Josiah's day?",
				"pt": "Qual profetisa confirmou o Livro da Lei nos dias de Josias?"
			},
			"answer": {"en": "Huldah", "pt": "Hulda"},
			"tier": 2,
			"decoys":
			[
				{"en": "Deborah", "pt": "Debora"},
				{"en": "Jael", "pt": "Jael"},
				{"en": "Miriam", "pt": "Miri?"}
			]
		},
		{
			"question":
			{
				"en": "Who hosted Elisha and built a room on her roof?",
				"pt": "Quem hospedou Eliseu e construiu um quarto no terra?o?"
			},
			"answer": {"en": "The Shunammite woman", "pt": "A sunamita"},
			"tier": 2,
			"decoys":
			[
				{"en": "Widow of Zarephath", "pt": "Vi?va de Sarepta"},
				{"en": "Widow with the oil", "pt": "Vi?va do azeite"},
				{"en": "Hannah", "pt": "Ana"}
			]
		},
		{
			"question":
			{
				"en": "Who had a jar of oil that filled many vessels by Elisha's word?",
				"pt":
				"Quem teve uma botija de azeite que encheu muitos vasos pela palavra de Eliseu?"
			},
			"answer": {"en": "The widow of a prophet", "pt": "A vi?va de um profeta"},
			"tier": 2,
			"decoys":
			[
				{"en": "Widow of Zarephath", "pt": "Vi?va de Sarepta"},
				{"en": "Ruth", "pt": "Rute"},
				{"en": "Esther", "pt": "Ester"}
			]
		},
		{
			"question":
			{
				"en": "Who hid a baby Joash in the temple to preserve the royal line?",
				"pt": "Quem escondeu o beb? Jo?s no templo para preservar a linhagem real?"
			},
			"answer": {"en": "Jehosheba", "pt": "Jeoseba"},
			"tier": 2,
			"decoys":
			[
				{"en": "Athaliah", "pt": "Atalia"},
				{"en": "Maacah", "pt": "Maaca"},
				{"en": "Abijah", "pt": "Abias"}
			]
		},
		{
			"question":
			{
				"en": "Who mocked David for dancing before the Lord?",
				"pt": "Quem zombou de Davi por dan?ar diante do Senhor?"
			},
			"answer": {"en": "Michal", "pt": "Mical"},
			"tier": 2,
			"decoys":
			[
				{"en": "Abigail", "pt": "Abigail"},
				{"en": "Bathsheba", "pt": "Bate-Seba"},
				{"en": "Tamar", "pt": "Tamar"}
			]
		},
		{
			"question":
			{
				"en": "Who betrayed Samson by cutting his hair?",
				"pt": "Quem traiu Sans?o cortando seu cabelo?"
			},
			"answer": {"en": "Delilah", "pt": "Dalila"},
			"tier": 2,
			"decoys":
			[
				{"en": "Jael", "pt": "Jael"},
				{"en": "Rahab", "pt": "Raabe"},
				{"en": "Athaliah", "pt": "Atalia"}
			]
		},
		{
			"question":
			{
				"en": "Who ruled Judah briefly and killed royal heirs?",
				"pt": "Quem governou Jud? brevemente e matou herdeiros reais?"
			},
			"answer": {"en": "Athaliah", "pt": "Atalia"},
			"tier": 2,
			"decoys":
			[
				{"en": "Vashti", "pt": "Vasti"},
				{"en": "Maacah", "pt": "Maaca"},
				{"en": "Jezebel", "pt": "Jezabel"}
			]
		},
		{
			"question":
			{
				"en": "Who drew Moses from the Nile and adopted him?",
				"pt": "Quem tirou Mois?s do Nilo e o adotou?"
			},
			"answer": {"en": "Pharaoh's daughter", "pt": "Filha do Fara?"},
			"tier": 2,
			"decoys":
			[
				{"en": "Jochebed", "pt": "Joquebede"},
				{"en": "Miriam", "pt": "Miri?"},
				{"en": "Zipporah", "pt": "Zipora"}
			]
		},
		{
			"question":
			{
				"en": "Who was mother of Perez and Zerah by Judah?",
				"pt": "Quem foi m?e de Perez e Zera de Jud??"
			},
			"answer": {"en": "Tamar (Judah's daughter-in-law)", "pt": "Tamar (nora de Jud?)"},
			"tier": 3,
			"decoys":
			[
				{"en": "Ruth", "pt": "Rute"},
				{"en": "Orpah", "pt": "Orfa"},
				{"en": "Leah", "pt": "Lia"}
			]
		},
		{
			"question":
			{
				"en": "Who was daughter of David violated by Amnon?",
				"pt": "Quem foi a filha de Davi violentada por Amnom?"
			},
			"answer": {"en": "Tamar (daughter of David)", "pt": "Tamar (filha de Davi)"},
			"tier": 3,
			"decoys":
			[
				{"en": "Tamar (Judah's daughter-in-law)", "pt": "Tamar (nora de Jud?)"},
				{"en": "Dinah", "pt": "Din?"},
				{"en": "Michal", "pt": "Mical"}
			]
		},
		{
			"question":
			{
				"en": "Who circumcised her son to save Moses' life on the journey?",
				"pt": "Quem circuncidou seu filho para salvar a vida de Mois?s na viagem?"
			},
			"answer": {"en": "Zipporah", "pt": "Zipora"},
			"tier": 3,
			"decoys":
			[
				{"en": "Jochebed", "pt": "Joquebede"},
				{"en": "Miriam", "pt": "Miri?"},
				{"en": "Elisheba", "pt": "Eliseba"}
			]
		},
		{
			"question":
			{
				"en": "Who was wronged at Shechem, prompting her brothers' revenge?",
				"pt": "Quem foi violentada em Siqu?m, provocando a vingan?a de seus irm?os?"
			},
			"answer": {"en": "Dinah", "pt": "Din?"},
			"tier": 3,
			"decoys":
			[
				{"en": "Leah", "pt": "Lia"},
				{"en": "Rachel", "pt": "Raquel"},
				{"en": "Deborah", "pt": "Debora"}
			]
		},
		{
			"question":
			{
				"en": "Who was the wicked wife of King Ahab?",
				"pt": "Quem era a esposa perversa do rei Acabe?"
			},
			"answer": {"en": "Jezebel", "pt": "Jezabel"},
			"tier": 3,
			"decoys":
			[
				{"en": "Athaliah", "pt": "Atalia"},
				{"en": "Vashti", "pt": "Vasti"},
				{"en": "Delilah", "pt": "Dalila"}
			]
		},
		{
			"question":
			{
				"en": "Who refused to appear before King Xerxes at his banquet?",
				"pt": "Quem se recusou a aparecer perante o rei Xerxes em seu banquete?"
			},
			"answer": {"en": "Vashti", "pt": "Vasti"},
			"tier": 3,
			"decoys":
			[
				{"en": "Esther", "pt": "Ester"},
				{"en": "Michal", "pt": "Mical"},
				{"en": "Bathsheba", "pt": "Bate-Seba"}
			]
		},
		{
			"question": {"en": "Who was wife of Aaron?", "pt": "Quem era a esposa de Ar?o?"},
			"answer": {"en": "Elisheba", "pt": "Eliseba"},
			"tier": 3,
			"decoys":
			[
				{"en": "Miriam", "pt": "Miri?"},
				{"en": "Zipporah", "pt": "Zipora"},
				{"en": "Naomi", "pt": "Noemi"}
			]
		},
		{
			"question":
			{
				"en": "Who tempted Joseph in Potiphar's house?",
				"pt": "Quem tentou Jos? na casa de Potifar?"
			},
			"answer": {"en": "Potiphar's wife", "pt": "Esposa de Potifar"},
			"tier": 3,
			"decoys":
			[
				{"en": "Pharaoh's wife", "pt": "Esposa do Fara?"},
				{"en": "Asenath", "pt": "Azenate"},
				{"en": "Dinah", "pt": "Din?"}
			]
		},
		{
			"question":
			{
				"en": "Which midwives feared God and spared Hebrew baby boys?",
				"pt": "Quais parteiras temeram a Deus e pouparam os meninos hebreus?"
			},
			"answer": {"en": "Shiphrah and Puah", "pt": "Sifrá e Puá"},
			"tier": 2,
			"decoys":
			[
				{"en": "Miriam and Jochebed", "pt": "Miriã e Joquebede"},
				{"en": "Hannah and Peninnah", "pt": "Ana e Penina"},
				{"en": "Leah and Rachel", "pt": "Lia e Raquel"}
			]
		},
		{
			"question":
			{
				"en": "Who was the unfaithful wife Hosea was told to marry?",
				"pt": "Quem foi a esposa infiel que Oséias foi instruído a tomar?"
			},
			"answer": {"en": "Gomer", "pt": "Gomer"},
			"tier": 3,
			"decoys":
			[
				{"en": "Hagar", "pt": "Agar"},
				{"en": "Maacah", "pt": "Maaca"},
				{"en": "Vashti", "pt": "Vasti"}
			]
		},
		{
			"question": {"en": "Who was Absalom's mother?", "pt": "Quem era a mãe de Absalão?"},
			"answer": {"en": "Maacah, daughter of Talmai", "pt": "Maaca, filha de Talmai"},
			"tier": 3,
			"decoys":
			[
				{"en": "Bathsheba", "pt": "Bate-Seba"},
				{"en": "Michal", "pt": "Mical"},
				{"en": "Tamar", "pt": "Tamar"}
			]
		}
	],
	"Miracles in the Old Testament":
	[
		{
			"question":
			{
				"en": "Whose staff became a serpent before Pharaoh?",
				"pt": "Qual bastão se tornou uma serpente diante do Faraó?"
			},
			"answer": {"en": "Aaron's", "pt": "Aarão"},
			"tier": 1,
			"decoys":
			[
				{"en": "Moses'", "pt": "Moisés'"},
				{"en": "Pharaoh's", "pt": "Faraó"},
				{"en": "Joshua's", "pt": "Josué"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet called fire from heaven on Mount Carmel?",
				"pt": "Qual profeta chamou fogo do céu no Monte Carmelo?"
			},
			"answer": {"en": "Elijah", "pt": "Elias"},
			"tier": 1,
			"decoys":
			[
				{"en": "Elisha", "pt": "Eliseu"},
				{"en": "Moses", "pt": "Moisés"},
				{"en": "Samuel", "pt": "Samuel"}
			]
		},
		{
			"question":
			{
				"en": "Who told Naaman to wash in the Jordan to be healed?",
				"pt": "Quem disse a Naamã para se lavar no Jordão para ser curado?"
			},
			"answer": {"en": "Elisha", "pt": "Eliseu"},
			"tier": 1,
			"decoys":
			[
				{"en": "Elijah", "pt": "Elias"},
				{"en": "Isaiah", "pt": "Isaías"},
				{"en": "Gehazi", "pt": "Geazi"}
			]
		},
		{
			"question":
			{
				"en": "Whose oil kept flowing to fill jars?",
				"pt": "De quem era o óleo que continuava fluindo para encher os potes?"
			},
			"answer": {"en": "The widow helped by Elisha", "pt": "A viúva ajudada por Eliseu"},
			"tier": 1,
			"decoys":
			[
				{"en": "The widow of Zarephath", "pt": "A viúva de Sarepta"},
				{"en": "Hannah", "pt": "Ana"},
				{"en": "Naomi", "pt": "Noemi"}
			]
		},
		{
			"question":
			{
				"en": "What sign did God give Hezekiah by the sun's shadow?",
				"pt": "Que sinal Deus deu a Ezequias pela sombra do sol?"
			},
			"answer": {"en": "It went backward", "pt": "Foi para trás"},
			"tier": 2,
			"decoys":
			[
				{"en": "It stood still", "pt": "Ficou parado"},
				{"en": "It darkened at noon", "pt": "Escureceu ao meio-dia"},
				{"en": "It sped forward", "pt": "Acelerou"}
			]
		},
		{
			"question":
			{
				"en": "Who made an iron axe head float?",
				"pt": "Quem fez flutuar a cabeça de um machado de ferro?"
			},
			"answer": {"en": "Elisha", "pt": "Eliseu"},
			"tier": 2,
			"decoys":
			[
				{"en": "Elijah", "pt": "Elias"},
				{"en": "Moses", "pt": "Moisés"},
				{"en": "Joshua", "pt": "Josué"}
			]
		},
		{
			"question":
			{
				"en": "Who raised a widow's son at Zarephath?",
				"pt": "Quem criou o filho de uma viúva em Sarepta?"
			},
			"answer": {"en": "Elijah", "pt": "Elias"},
			"tier": 2,
			"decoys":
			[
				{"en": "Elisha", "pt": "Eliseu"},
				{"en": "Peter", "pt": "Peter"},
				{"en": "Paul", "pt": "Paulo"}
			]
		},
		{
			"question":
			{
				"en": "What river parted for Elijah and Elisha?",
				"pt": "Que rio se abriu para Elias e Eliseu?"
			},
			"answer": {"en": "The Jordan", "pt": "O Jordão"},
			"tier": 1,
			"decoys":
			[
				{"en": "The Euphrates", "pt": "O Eufrates"},
				{"en": "The Nile", "pt": "O Nilo"},
				{"en": "The Arnon", "pt": "O Arnon"}
			]
		},
		{
			"question":
			{
				"en": "Who healed waters of Jericho with salt?",
				"pt": "Quem curou as águas de Jericó com sal?"
			},
			"answer": {"en": "Elisha", "pt": "Eliseu"},
			"tier": 2,
			"decoys":
			[
				{"en": "Elijah", "pt": "Elias"},
				{"en": "Moses", "pt": "Moisés"},
				{"en": "Joshua", "pt": "Josué"}
			]
		},
		{
			"question":
			{
				"en": "Who was healed when he looked at the bronze serpent?",
				"pt": "Quem foi curado quando olhou para a serpente de bronze?"
			},
			"answer": {"en": "Israelites bitten by snakes", "pt": "Israelitas mordidos por cobras"},
			"tier": 1,
			"decoys":
			[
				{"en": "Philistines", "pt": "Filisteus"},
				{"en": "Syrians", "pt": "Sírios"},
				{"en": "Moabites", "pt": "Moabitas"}
			]
		},
		{
			"question":
			{
				"en": "Who stretched out his staff and the sea parted?",
				"pt": "Quem estendeu o seu cajado e o mar se abriu?"
			},
			"answer": {"en": "Moses", "pt": "Moisés"},
			"tier": 1,
			"decoys":
			[
				{"en": "Aaron", "pt": "Aarão"},
				{"en": "Joshua", "pt": "Josué"},
				{"en": "Elijah", "pt": "Elias"}
			]
		},
		{
			"question":
			{
				"en": "Who called fire to consume two captains of fifty?",
				"pt": "Quem chamou o fogo para consumir dois capitães de cinquenta?"
			},
			"answer": {"en": "Elijah", "pt": "Elias"},
			"tier": 2,
			"decoys":
			[
				{"en": "Elisha", "pt": "Eliseu"},
				{"en": "Moses", "pt": "Moisés"},
				{"en": "Samuel", "pt": "Samuel"}
			]
		},
		{
			"question":
			{"en": "Who stopped the sun for a day?", "pt": "Quem parou o sol por um dia?"},
			"answer": {"en": "Joshua", "pt": "Josué"},
			"tier": 1,
			"decoys":
			[
				{"en": "Moses", "pt": "Moisés"},
				{"en": "Gideon", "pt": "Gideão"},
				{"en": "Samson", "pt": "Sansão"}
			]
		},
		{
			"question":
			{
				"en": "Who made bitter waters sweet at Marah?",
				"pt": "Quem tornou doces as águas amargas em Mara?"
			},
			"answer": {"en": "Moses", "pt": "Moisés"},
			"tier": 1,
			"decoys":
			[
				{"en": "Aaron", "pt": "Aarão"},
				{"en": "Joshua", "pt": "Josué"},
				{"en": "Elijah", "pt": "Elias"}
			]
		},
		{
			"question":
			{
				"en": "Who saw chariots of fire protecting Dothan?",
				"pt": "Quem viu carros de fogo protegendo Dotã?"
			},
			"answer": {"en": "Elisha's servant", "pt": "Servo de Eliseu"},
			"tier": 2,
			"decoys":
			[
				{"en": "Gehazi", "pt": "Geazi"},
				{"en": "Naaman", "pt": "Naamã"},
				{"en": "Joash", "pt": "Joás"}
			]
		},
		{
			"question":
			{
				"en": "What fell from heaven with manna at evening?",
				"pt": "O que caiu do céu com o maná à noite?"
			},
			"answer": {"en": "Quail", "pt": "Codorniz"},
			"tier": 1,
			"decoys":
			[
				{"en": "Doves", "pt": "Pombas"},
				{"en": "Fish", "pt": "Peixe"},
				{"en": "Locusts", "pt": "Gafanhotos"}
			]
		},
		{
			"question":
			{
				"en": "Who made water come from a rock by speaking?",
				"pt": "Quem fez a água sair de uma rocha falando?"
			},
			"answer": {"en": "Moses", "pt": "Moisés"},
			"tier": 2,
			"decoys":
			[
				{"en": "Aaron", "pt": "Aarão"},
				{"en": "Joshua", "pt": "Josué"},
				{"en": "Elijah", "pt": "Elias"}
			]
		},
		{
			"question":
			{
				"en": "Who split the Jordan by striking it with Elijah's cloak?",
				"pt": "Quem dividiu o Jordão, golpeando-o com o manto de Elias?"
			},
			"answer": {"en": "Elisha", "pt": "Eliseu"},
			"tier": 2,
			"decoys":
			[
				{"en": "Gehazi", "pt": "Geazi"},
				{"en": "Samuel", "pt": "Samuel"},
				{"en": "Isaiah", "pt": "Isaías"}
			]
		},
		{
			"question":
			{
				"en": "Who saw the earth open to swallow rebels?",
				"pt": "Quem viu a terra se abrir para engolir os rebeldes?"
			},
			"answer": {"en": "Moses", "pt": "Moisés"},
			"tier": 2,
			"decoys":
			[
				{"en": "Joshua", "pt": "Josué"},
				{"en": "Caleb", "pt": "Calebe"},
				{"en": "Aaron", "pt": "Aarão"}
			]
		},
		{
			"question":
			{
				"en": "Who received a double portion of Elijah's spirit?",
				"pt": "Quem recebeu porção dobrada do espírito de Elias?"
			},
			"answer": {"en": "Elisha", "pt": "Eliseu"},
			"tier": 2,
			"decoys":
			[
				{"en": "Gehazi", "pt": "Geazi"},
				{"en": "Samuel", "pt": "Samuel"},
				{"en": "Isaiah", "pt": "Isaías"}
			]
		},
		{
			"question":
			{
				"en": "Whose rod blossomed with almond flowers as a sign?",
				"pt": "De quem a vara floresceu com amendoeiras como sinal?"
			},
			"answer": {"en": "Aaron", "pt": "Aar?o"},
			"tier": 3,
			"decoys":
			[
				{"en": "Moses", "pt": "Mois?s"},
				{"en": "Joshua", "pt": "Josu?"},
				{"en": "Elijah", "pt": "Elias"}
			]
		},
		{
			"question":
			{
				"en": "Who made bitter water sweet at Marah?",
				"pt": "Quem tornou doce a ?gua amarga em Mara?"
			},
			"answer": {"en": "Moses", "pt": "Mois?s"},
			"tier": 3,
			"decoys":
			[
				{"en": "Elisha", "pt": "Eliseu"},
				{"en": "Joshua", "pt": "Josu?"},
				{"en": "Samuel", "pt": "Samuel"}
			]
		},
		{
			"question":
			{
				"en": "Who called down fire to consume a soaked sacrifice on Carmel?",
				"pt": "Quem clamou fogo para consumir um sacrif?cio encharcado no Carmelo?"
			},
			"answer": {"en": "Elijah", "pt": "Elias"},
			"tier": 3,
			"decoys":
			[
				{"en": "Elisha", "pt": "Eliseu"},
				{"en": "Moses", "pt": "Mois?s"},
				{"en": "Gideon", "pt": "Gide?o"}
			]
		},
		{
			"question":
			{
				"en": "Who stretched out his staff and the sea parted?",
				"pt": "Quem estendeu o cajado e o mar se abriu?"
			},
			"answer": {"en": "Moses", "pt": "Mois?s"},
			"tier": 3,
			"decoys":
			[
				{"en": "Aaron", "pt": "Aar?o"},
				{"en": "Joshua", "pt": "Josu?"},
				{"en": "Caleb", "pt": "Calebe"}
			]
		},
		{
			"question":
			{
				"en": "Who saw the sun and shadow go back ten steps as a sign?",
				"pt": "Quem viu o sol e a sombra voltarem dez degraus como sinal?"
			},
			"answer": {"en": "King Hezekiah", "pt": "Rei Ezequias"},
			"tier": 3,
			"decoys":
			[
				{"en": "King Jehoshaphat", "pt": "Rei Josaf?"},
				{"en": "King Asa", "pt": "Rei Asa"},
				{"en": "King Josiah", "pt": "Rei Josias"}
			]
		},
		{
			"question":
			{
				"en": "Who made an iron axe head float on the Jordan?",
				"pt": "Quem fez o ferro do machado flutuar no Jord?o?"
			},
			"answer": {"en": "Elisha", "pt": "Eliseu"},
			"tier": 3,
			"decoys":
			[
				{"en": "Elijah", "pt": "Elias"},
				{"en": "Moses", "pt": "Mois?s"},
				{"en": "Joshua", "pt": "Josu?"}
			]
		},
		{
			"question":
			{
				"en": "Who raised a Shunammite's son from the dead?",
				"pt": "Quem ressuscitou o filho da sunamita?"
			},
			"answer": {"en": "Elisha", "pt": "Eliseu"},
			"tier": 3,
			"decoys":
			[
				{"en": "Elijah", "pt": "Elias"},
				{"en": "Isaiah", "pt": "Isa?as"},
				{"en": "Jeremiah", "pt": "Jeremias"}
			]
		},
		{
			"question":
			{
				"en": "Whose bones revived a dead man when touched?",
				"pt": "De quem os ossos reviveram um morto ao serem tocados?"
			},
			"answer": {"en": "Elisha", "pt": "Eliseu"},
			"tier": 3,
			"decoys":
			[
				{"en": "Elijah", "pt": "Elias"},
				{"en": "Isaiah", "pt": "Isa?as"},
				{"en": "Samuel", "pt": "Samuel"}
			]
		},
		{
			"question":
			{
				"en": "Who called fire to consume two captains of fifty?",
				"pt": "Quem chamou fogo para consumir dois capit?es de cinquenta?"
			},
			"answer": {"en": "Elijah", "pt": "Elias"},
			"tier": 3,
			"decoys":
			[
				{"en": "Moses", "pt": "Mois?s"},
				{"en": "Samuel", "pt": "Samuel"},
				{"en": "Gideon", "pt": "Gide?o"}
			]
		},
		{
			"question":
			{
				"en": "Who saw a fiery chariot take his master up to heaven?",
				"pt": "Quem viu um carro de fogo levar seu mestre aos c?us?"
			},
			"answer": {"en": "Elisha", "pt": "Eliseu"},
			"tier": 3,
			"decoys":
			[
				{"en": "Gehazi", "pt": "Geazi"},
				{"en": "Obadiah", "pt": "Obadias"},
				{"en": "Jehu", "pt": "Je?"}
			]
		}
	],
	"Birth of Jesus":
	[
		{
			"question": {"en": "Where was Jesus born?", "pt": "Onde Jesus nasceu?"},
			"answer": {"en": "Bethlehem", "pt": "Bel?m"},
			"tier": 1,
			"decoys":
			[
				{"en": "Nazareth", "pt": "Nazar?"},
				{"en": "Jerusalem", "pt": "Jerusal?m"},
				{"en": "Capernaum", "pt": "Cafarnaum"}
			]
		},
		{
			"question": {"en": "Who was Jesus' mother?", "pt": "Quem foi a m?e de Jesus?"},
			"answer": {"en": "Mary", "pt": "Maria"},
			"tier": 1,
			"decoys":
			[
				{"en": "Elizabeth", "pt": "Elisabete"},
				{"en": "Martha", "pt": "Marta"},
				{"en": "Salome", "pt": "Salom?"}
			]
		},
		{
			"question":
			{
				"en": "Where was Jesus laid after birth?",
				"pt": "Onde Jesus foi colocado apos o nascimento?"
			},
			"answer": {"en": "In a manger", "pt": "Numa manjedoura"},
			"tier": 1,
			"decoys":
			[
				{"en": "In a crib", "pt": "Num ber?o"},
				{"en": "In a basket", "pt": "Numa cesta"},
				{"en": "On straw in a cave", "pt": "Na palha de uma caverna"}
			]
		},
		{
			"question":
			{
				"en": "Who announced the good news to shepherds?",
				"pt": "Quem anunciou as boas novas aos pastores?"
			},
			"answer": {"en": "Angels", "pt": "Anjos"},
			"tier": 1,
			"decoys":
			[
				{"en": "Wise men", "pt": "Magos"},
				{"en": "Priests", "pt": "Sacerdotes"},
				{"en": "Prophets", "pt": "Profetas"}
			]
		},
		{
			"question":
			{
				"en": "Who was Jesus' earthly guardian from David's line?",
				"pt": "Quem foi o guardi?o terreno de Jesus da linhagem de Davi?"
			},
			"answer": {"en": "Joseph", "pt": "Jos?"},
			"tier": 1,
			"decoys":
			[
				{"en": "Zechariah", "pt": "Zacarias"},
				{"en": "Simeon", "pt": "Sime?o"},
				{"en": "Nicodemus", "pt": "Nicodemos"}
			]
		},
		{
			"question":
			{
				"en": "Who visited Jesus guided by a star?",
				"pt": "Quem visitou Jesus guiado por uma estrela?"
			},
			"answer": {"en": "Wise men from the east", "pt": "Magos do oriente"},
			"tier": 1,
			"decoys":
			[
				{"en": "Shepherds from Judea", "pt": "Pastores da Judeia"},
				{"en": "Priests from Jerusalem", "pt": "Sacerdotes de Jerusal?m"},
				{"en": "Merchants from Damascus", "pt": "Mercadores de Damasco"}
			]
		},
		{
			"question":
			{"en": "What gifts did the wise men bring?", "pt": "Que presentes os magos trouxeram?"},
			"answer": {"en": "Gold, frankincense, and myrrh", "pt": "Ouro, incenso e mirra"},
			"tier": 1,
			"decoys":
			[
				{"en": "Silver, spices, and oil", "pt": "Prata, especiarias e ?leo"},
				{"en": "Wine, wool, and grain", "pt": "Vinho, l? e gr?o"},
				{"en": "Iron, silk, and salt", "pt": "Ferro, seda e sal"}
			]
		},
		{
			"question":
			{
				"en": "Where did the family flee from Herod?",
				"pt": "Para onde a fam?lia fugiu de Herodes?"
			},
			"answer": {"en": "Egypt", "pt": "Egito"},
			"tier": 1,
			"decoys":
			[
				{"en": "Syria", "pt": "S?ria"},
				{"en": "Babylon", "pt": "Babil?nia"},
				{"en": "Rome", "pt": "Roma"}
			]
		},
		{
			"question":
			{
				"en": "Who ordered the massacre of infants in Bethlehem?",
				"pt": "Quem ordenou a morte dos beb?s em Bel?m?"
			},
			"answer": {"en": "Herod the Great", "pt": "Herodes, o Grande"},
			"tier": 1,
			"decoys":
			[
				{"en": "Pilate", "pt": "Pilatos"},
				{"en": "Herod Antipas", "pt": "Herodes Antipas"},
				{"en": "Augustus", "pt": "Augusto"}
			]
		},
		{
			"question":
			{
				"en": "What name was given because He will save His people?",
				"pt": "Que nome foi dado porque Ele salvar? Seu povo?"
			},
			"answer": {"en": "Jesus", "pt": "Jesus"},
			"tier": 1,
			"decoys":
			[
				{"en": "Emmanuel", "pt": "Emanuel"},
				{"en": "Christ", "pt": "Cristo"},
				{"en": "Messiah", "pt": "Messias"}
			]
		},
		{
			"question":
			{
				"en": "What sign did the angel give to shepherds?",
				"pt": "Que sinal o anjo deu aos pastores?"
			},
			"answer":
			{
				"en": "A baby wrapped in cloths in a manger",
				"pt": "Um beb? envolto em panos numa manjedoura"
			},
			"tier": 2,
			"decoys":
			[
				{"en": "A star over a house", "pt": "Uma estrela sobre uma casa"},
				{"en": "A crown on a child", "pt": "Uma coroa numa crian?a"},
				{"en": "A lamb by the child", "pt": "Um cordeiro ao lado da crian?a"}
			]
		},
		{
			"question":
			{
				"en": "Who decreed the census bringing Mary and Joseph to Bethlehem?",
				"pt": "Quem decretou o censo que levou Maria e Jos? a Bel?m?"
			},
			"answer": {"en": "Caesar Augustus", "pt": "C?sar Augusto"},
			"tier": 2,
			"decoys":
			[
				{"en": "Herod", "pt": "Herodes"},
				{"en": "Quirinius", "pt": "Quirino"},
				{"en": "Tiberius", "pt": "Tib?rio"}
			]
		},
		{
			"question":
			{
				"en": "Which prophetess rejoiced in the temple at Jesus' presentation?",
				"pt": "Qual profetisa se alegrou no templo na apresenta??o de Jesus?"
			},
			"answer": {"en": "Anna", "pt": "Ana"},
			"tier": 2,
			"decoys":
			[
				{"en": "Huldah", "pt": "Hulda"},
				{"en": "Deborah", "pt": "D?bora"},
				{"en": "Elizabeth", "pt": "Elisabete"}
			]
		},
		{
			"question":
			{
				"en": "Who told Joseph to flee to Egypt?",
				"pt": "Quem disse a Jos? para fugir para o Egito?"
			},
			"answer": {"en": "An angel in a dream", "pt": "Um anjo em sonho"},
			"tier": 2,
			"decoys":
			[
				{"en": "Simeon", "pt": "Sime?o"},
				{"en": "Gabriel in the temple", "pt": "Gabriel no templo"},
				{"en": "Herod's messenger", "pt": "Mensageiro de Herodes"}
			]
		},
		{
			"question":
			{
				"en": "Who told Joseph to return from Egypt after Herod died?",
				"pt": "Quem disse a Jos? para voltar do Egito ap?s Herodes morrer?"
			},
			"answer": {"en": "An angel in a dream", "pt": "Um anjo em sonho"},
			"tier": 2,
			"decoys":
			[
				{"en": "Zechariah", "pt": "Zacarias"},
				{"en": "Gabriel in person", "pt": "Gabriel em pessoa"},
				{"en": "A prophetess", "pt": "Uma profetisa"}
			]
		},
		{
			"question":
			{
				"en": "Which angel spoke to Mary about bearing Jesus?",
				"pt": "Qual anjo falou a Maria sobre conceber Jesus?"
			},
			"answer": {"en": "Gabriel", "pt": "Gabriel"},
			"tier": 2,
			"decoys":
			[
				{"en": "Michael", "pt": "Miguel"},
				{"en": "Raphael", "pt": "Rafael"},
				{"en": "Uriel", "pt": "Uriel"}
			]
		},
		{
			"question":
			{
				"en": "Who was Mary's relative expecting John the Baptist?",
				"pt": "Qual parente de Maria esperava Jo?o Batista?"
			},
			"answer": {"en": "Elizabeth", "pt": "Elisabete"},
			"tier": 2,
			"decoys":
			[
				{"en": "Anna", "pt": "Ana"},
				{"en": "Salome", "pt": "Salom?"},
				{"en": "Martha", "pt": "Marta"}
			]
		},
		{
			"question":
			{
				"en": "Where was Jesus presented according to the law?",
				"pt": "Onde Jesus foi apresentado segundo a lei?"
			},
			"answer": {"en": "In the temple at Jerusalem", "pt": "No templo em Jerusal?m"},
			"tier": 2,
			"decoys":
			[
				{"en": "At Nazareth synagogue", "pt": "Na sinagoga de Nazar?"},
				{"en": "At Bethlehem's gate", "pt": "No port?o de Bel?m"},
				{"en": "At Mount Gerizim", "pt": "No Monte Gerizim"}
			]
		},
		{
			"question":
			{
				"en": "What offering did Joseph and Mary bring at Jesus' presentation?",
				"pt": "Que oferta Jos? e Maria trouxeram na apresenta??o de Jesus?"
			},
			"answer": {"en": "Two turtledoves or pigeons", "pt": "Duas rolas ou pombos"},
			"tier": 2,
			"decoys":
			[
				{"en": "A lamb", "pt": "Um cordeiro"},
				{"en": "A grain offering", "pt": "Uma oferta de cereal"},
				{"en": "A silver coin", "pt": "Uma moeda de prata"}
			]
		},
		{
			"question": {"en": "Joseph was from which house?", "pt": "Jos? era de qual casa?"},
			"answer": {"en": "House of David", "pt": "Casa de Davi"},
			"tier": 2,
			"decoys":
			[
				{"en": "House of Saul", "pt": "Casa de Saul"},
				{"en": "House of Levi", "pt": "Casa de Levi"},
				{"en": "House of Benjamin", "pt": "Casa de Benjamin"}
			]
		},
		{
			"question":
			{
				"en": "Who prophesied that a sword would pierce Mary's soul?",
				"pt": "Quem profetizou que uma espada traspassaria a alma de Maria?"
			},
			"answer": {"en": "Simeon", "pt": "Sime?o"},
			"tier": 3,
			"decoys":
			[
				{"en": "Zechariah", "pt": "Zacarias"},
				{"en": "Joseph", "pt": "Jos?"},
				{"en": "John the Baptist", "pt": "Jo?o Batista"}
			]
		},
		{
			"question":
			{
				"en": "Who recognized Jesus as a light for the Gentiles?",
				"pt": "Quem reconheceu Jesus como luz para os gentios?"
			},
			"answer": {"en": "Simeon", "pt": "Sime?o"},
			"tier": 3,
			"decoys":
			[
				{"en": "Nicodemus", "pt": "Nicodemos"},
				{"en": "Gamaliel", "pt": "Gamaliel"},
				{"en": "Caiaphas", "pt": "Caif?s"}
			]
		},
		{
			"question":
			{
				"en": "Which Old Testament book foretold Bethlehem as Messiah's birthplace?",
				"pt": "Qual livro do AT previu Bel?m como local do nascimento do Messias?"
			},
			"answer": {"en": "Micah", "pt": "Miqu?ias"},
			"tier": 3,
			"decoys":
			[
				{"en": "Isaiah", "pt": "Isa?as"},
				{"en": "Hosea", "pt": "Os?ias"},
				{"en": "Malachi", "pt": "Malaquias"}
			]
		},
		{
			"question":
			{
				"en": "Who warned the magi not to return to Herod?",
				"pt": "Quem advertiu os magos a n?o retornarem a Herodes?"
			},
			"answer": {"en": "God in a dream", "pt": "Deus em sonho"},
			"tier": 3,
			"decoys":
			[
				{"en": "Gabriel", "pt": "Gabriel"},
				{"en": "Herod's scribe", "pt": "Escriba de Herodes"},
				{"en": "A shepherd", "pt": "Um pastor"}
			]
		},
		{
			"question":
			{
				"en": "Where was Jesus when the wise men visited him?",
				"pt": "Onde Jesus estava quando os magos o visitaram?"
			},
			"answer": {"en": "In a house", "pt": "Em uma casa"},
			"tier": 3,
			"decoys":
			[
				{"en": "In the manger", "pt": "Na manjedoura"},
				{"en": "In the temple", "pt": "No templo"},
				{"en": "On the road", "pt": "Na estrada"}
			]
		},
		{
			"question":
			{
				"en": "Which ruler reigned in Judea after Herod, causing Joseph to avoid Judea?",
				"pt":
				"Qual governante reinava na Judeia ap?s Herodes, levando Jos? a evitar a Judeia?"
			},
			"answer": {"en": "Archelaus", "pt": "Arquelau"},
			"tier": 3,
			"decoys":
			[
				{"en": "Herod Antipas", "pt": "Herodes Antipas"},
				{"en": "Pilate", "pt": "Pilatos"},
				{"en": "Philip", "pt": "Filipe"}
			]
		},
		{
			"question":
			{
				"en": "Who was governor of Syria during the census?",
				"pt": "Quem era governador da S?ria durante o censo?"
			},
			"answer": {"en": "Quirinius", "pt": "Quirino"},
			"tier": 3,
			"decoys":
			[
				{"en": "Augustus", "pt": "Augusto"},
				{"en": "Festus", "pt": "Festo"},
				{"en": "Felix", "pt": "F?lix"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet's words 'Out of Egypt I called my son' were fulfilled?",
				"pt": "As palavras de qual profeta 'Do Egito chamei meu filho' foram cumpridas?"
			},
			"answer": {"en": "Hosea", "pt": "Os?ias"},
			"tier": 3,
			"decoys":
			[
				{"en": "Isaiah", "pt": "Isa?as"},
				{"en": "Jeremiah", "pt": "Jeremias"},
				{"en": "Micah", "pt": "Miqu?ias"}
			]
		},
		{
			"question":
			{
				"en": "How old was Jesus when presented at the temple?",
				"pt": "Quantos dias tinha Jesus quando foi apresentado no templo?"
			},
			"answer": {"en": "About forty days", "pt": "Cerca de quarenta dias"},
			"tier": 3,
			"decoys":
			[
				{"en": "Eight days", "pt": "Oito dias"},
				{"en": "Twelve years", "pt": "Doze anos"},
				{"en": "Thirty days", "pt": "Trinta dias"}
			]
		},
		{
			"question":
			{
				"en": "Where did Mary keep pondering these things?",
				"pt": "Onde Maria guardava e meditava sobre essas coisas?"
			},
			"answer": {"en": "In her heart", "pt": "Em seu cora??o"},
			"tier": 3,
			"decoys":
			[
				{"en": "In a scroll", "pt": "Em um pergaminho"},
				{"en": "With Elizabeth", "pt": "Com Elisabete"},
				{"en": "With Simeon", "pt": "Com Sime?o"}
			]
		}
	],
	"Miracles of Jesus":
	[
		{
			"question":
			{
				"en": "What did Jesus turn water into at Cana?",
				"pt": "Em que Jesus transformou a agua em Cana?"
			},
			"answer": {"en": "Wine", "pt": "Vinho"},
			"tier": 1,
			"decoys":
			[
				{"en": "Grape juice", "pt": "Suco de uva"},
				{"en": "Olive oil", "pt": "Azeite"},
				{"en": "Nothing changed", "pt": "Nada mudou"}
			]
		},
		{
			"question":
			{
				"en": "How many were fed with five loaves and two fish?",
				"pt": "Quantos foram alimentados com cinco paes e dois peixes?"
			},
			"answer": {"en": "About five thousand men", "pt": "Cerca de cinco mil homens"},
			"tier": 1,
			"decoys":
			[
				{"en": "About four thousand", "pt": "Cerca de quatro mil"},
				{"en": "About three thousand", "pt": "Cerca de tres mil"},
				{"en": "About two thousand", "pt": "Cerca de dois mil"}
			]
		},
		{
			"question":
			{
				"en": "How did Jesus calm the storm on the Sea of Galilee?",
				"pt": "Como Jesus acalmou a tempestade no Mar da Galileia?"
			},
			"answer":
			{"en": "He rebuked the wind and waves", "pt": "Repreendeu o vento e as ondas"},
			"tier": 1,
			"decoys":
			[
				{"en": "He dropped anchor", "pt": "Largou a ancora"},
				{"en": "He waited for sunrise", "pt": "Esperou o amanhecer"},
				{"en": "He asked the sailors to row harder", "pt": "Pediu que remassem mais forte"}
			]
		},
		{
			"question":
			{
				"en": "Who was healed after being lowered through a roof?",
				"pt": "Quem foi curado depois de ser descido pelo telhado?"
			},
			"answer": {"en": "A paralyzed man", "pt": "Um homem paralitico"},
			"tier": 1,
			"decoys":
			[
				{"en": "A blind beggar", "pt": "Um cego mendigo"},
				{"en": "A tax collector", "pt": "Um cobrador de impostos"},
				{"en": "A priest", "pt": "Um sacerdote"}
			]
		},
		{
			"question":
			{
				"en": "What surface did Jesus walk on to reach his disciples?",
				"pt": "Sobre o que Jesus caminhou para alcancar seus discipulos?"
			},
			"answer": {"en": "On the water", "pt": "Sobre a agua"},
			"tier": 1,
			"decoys":
			[
				{"en": "On a sandbar", "pt": "Num banco de areia"},
				{"en": "On another boat", "pt": "Em outro barco"},
				{"en": "On a stone path", "pt": "Num caminho de pedra"}
			]
		},
		{
			"question":
			{
				"en": "Who cried 'Son of David, have mercy on me' near Jericho?",
				"pt": "Quem clamou 'Filho de Davi, tem misericordia de mim' perto de Jerico?"
			},
			"answer": {"en": "Bartimaeus", "pt": "Bartimeu"},
			"tier": 1,
			"decoys":
			[
				{"en": "Zacchaeus", "pt": "Zaqueu"},
				{"en": "Nicodemus", "pt": "Nicodemos"},
				{"en": "Barabbas", "pt": "Barrabas"}
			]
		},
		{
			"question":
			{
				"en": "Whose daughter did Jesus raise saying 'Talitha koum'?",
				"pt": "De quem Jesus levantou a filha dizendo 'Talitha koum'?"
			},
			"answer": {"en": "Jairus' daughter", "pt": "A filha de Jairo"},
			"tier": 1,
			"decoys":
			[
				{"en": "Widow's son at Nain", "pt": "O filho da viuva de Naim"},
				{"en": "Lazarus", "pt": "Lazaro"},
				{"en": "The Shunammite's son", "pt": "O filho da sunamita"}
			]
		},
		{
			"question":
			{
				"en": "Who was healed by touching the edge of Jesus' cloak?",
				"pt": "Quem foi curada ao tocar a orla do manto de Jesus?"
			},
			"answer": {"en": "A woman with bleeding", "pt": "Uma mulher com fluxo de sangue"},
			"tier": 1,
			"decoys":
			[
				{"en": "Mary Magdalene", "pt": "Maria Madalena"},
				{"en": "Martha", "pt": "Marta"},
				{"en": "The Samaritan woman", "pt": "A mulher samaritana"}
			]
		},
		{
			"question":
			{
				"en": "Whom did Jesus heal of fever in Peter's house?",
				"pt": "Quem Jesus curou da febre na casa de Pedro?"
			},
			"answer": {"en": "Peter's mother-in-law", "pt": "A sogra de Pedro"},
			"tier": 1,
			"decoys":
			[
				{"en": "Peter's daughter", "pt": "A filha de Pedro"},
				{"en": "Andrew's wife", "pt": "A esposa de Andre"},
				{"en": "James' mother", "pt": "A mae de Tiago"}
			]
		},
		{
			"question":
			{
				"en": "Who said 'If you are willing, you can make me clean'?",
				"pt": "Quem disse 'Se quiseres, podes purificar-me'?"
			},
			"answer": {"en": "A man with leprosy", "pt": "Um homem com lepra"},
			"tier": 1,
			"decoys":
			[
				{"en": "A Roman centurion", "pt": "Um centuriao romano"},
				{"en": "A blind man", "pt": "Um cego"},
				{"en": "A lame beggar", "pt": "Um mendigo coxo"}
			]
		},
		{
			"question":
			{
				"en": "How many lepers were cleansed when only one returned to thank Jesus?",
				"pt": "Quantos leprosos foram purificados quando apenas um voltou para agradecer?"
			},
			"answer": {"en": "Ten lepers", "pt": "Dez leprosos"},
			"tier": 2,
			"decoys":
			[
				{"en": "Seven lepers", "pt": "Sete leprosos"},
				{"en": "Nine lepers", "pt": "Nove leprosos"},
				{"en": "Twelve lepers", "pt": "Doze leprosos"}
			]
		},
		{
			"question":
			{
				"en": "Whose servant did Jesus heal from a distance because of great faith?",
				"pt": "O servo de quem Jesus curou a distancia por causa da fe?"
			},
			"answer": {"en": "A Roman centurion's servant", "pt": "O servo de um centuriao romano"},
			"tier": 2,
			"decoys":
			[
				{"en": "A synagogue ruler's servant", "pt": "O servo de um lider de sinagoga"},
				{"en": "A Pharisee's servant", "pt": "O servo de um fariseu"},
				{"en": "A temple guard's servant", "pt": "O servo de um guarda do templo"}
			]
		},
		{
			"question":
			{
				"en": "What did Jesus place on a man born blind before sending him to Siloam?",
				"pt": "O que Jesus colocou em um homem cego de nascen a antes de envia-lo a Silo?m?"
			},
			"answer": {"en": "Mud made with spit", "pt": "Barro feito com saliva"},
			"tier": 2,
			"decoys":
			[
				{"en": "Oil from the lampstand", "pt": "Oleo do candelabro"},
				{"en": "Water from the Jordan", "pt": "Agua do Jordao"},
				{"en": "Perfume and spices", "pt": "Perfume e especiarias"}
			]
		},
		{
			"question":
			{
				"en": "Into what animals did Jesus send the demons from the Gerasene man?",
				"pt": "Para que animais Jesus enviou os demonios do homem gadareno?"
			},
			"answer": {"en": "A herd of pigs", "pt": "Uma manada de porcos"},
			"tier": 2,
			"decoys":
			[
				{"en": "A flock of goats", "pt": "Um rebanho de cabras"},
				{"en": "A herd of cattle", "pt": "Um rebanho de gado"},
				{"en": "A swarm of birds", "pt": "Um bando de aves"}
			]
		},
		{
			"question":
			{
				"en": "With what did Jesus feed the crowd of about four thousand?",
				"pt": "Com o que Jesus alimentou a multidao de cerca de quatro mil?"
			},
			"answer": {"en": "Seven loaves and a few fish", "pt": "Sete paes e alguns peixes"},
			"tier": 2,
			"decoys":
			[
				{"en": "Five loaves and two fish", "pt": "Cinco paes e dois peixes"},
				{"en": "Manna from heaven", "pt": "Mana do ceu"},
				{"en": "Barley cakes from a boy", "pt": "Bolos de cevada de um menino"}
			]
		},
		{
			"question":
			{
				"en": "Where was the man who had been an invalid for thirty-eight years healed?",
				"pt": "Onde foi curado o homem que era invalido ha trinta e oito anos?"
			},
			"answer": {"en": "At the pool of Bethesda", "pt": "No tanque de Betesda"},
			"tier": 2,
			"decoys":
			[
				{"en": "At the pool of Siloam", "pt": "No tanque de Siloam"},
				{"en": "By the Jordan River", "pt": "No rio Jordao"},
				{"en": "At Jacob's well", "pt": "No poco de Jaco"}
			]
		},
		{
			"question":
			{
				"en": "Whom did Jesus deliver when a boy kept falling into fire and water?",
				"pt": "Quem Jesus libertou quando um menino caia no fogo e na agua?"
			},
			"answer": {"en": "A boy with an unclean spirit", "pt": "Um menino com espirito impuro"},
			"tier": 2,
			"decoys":
			[
				{"en": "A man living among tombs", "pt": "Um homem que vivia entre sepulcros"},
				{"en": "A girl in Tyre", "pt": "Uma menina em Tiro"},
				{"en": "A nobleman's son", "pt": "O filho de um oficial"}
			]
		},
		{
			"question":
			{
				"en":
				"What part of the body did Jesus restore when it was withered in a synagogue?",
				"pt":
				"Qual parte do corpo Jesus restaurou quando estava ressequida em uma sinagoga?"
			},
			"answer": {"en": "A man's hand", "pt": "A mao de um homem"},
			"tier": 2,
			"decoys":
			[
				{"en": "A man's foot", "pt": "O pe de um homem"},
				{"en": "A woman's eye", "pt": "O olho de uma mulher"},
				{"en": "A servant's ear", "pt": "A orelha de um servo"}
			]
		},
		{
			"question":
			{
				"en": "Which miracle included Jesus saying 'Ephphatha'?",
				"pt": "Qual milagre incluiu Jesus dizendo 'Ephphatha'?"
			},
			"answer": {"en": "Healing a deaf and mute man", "pt": "Curar um homem surdo e mudo"},
			"tier": 2,
			"decoys":
			[
				{"en": "Raising Jairus' daughter", "pt": "Levantar a filha de Jairo"},
				{"en": "Calming the storm", "pt": "Acalmar a tempestade"},
				{"en": "Feeding the 5,000", "pt": "Alimentar os 5.000"}
			]
		},
		{
			"question":
			{
				"en": "Whose son in Capernaum was healed the moment Jesus spoke?",
				"pt": "O filho de quem em Cafarnaum foi curado no momento em que Jesus falou?"
			},
			"answer": {"en": "A royal official's son", "pt": "O filho de um oficial do rei"},
			"tier": 2,
			"decoys":
			[
				{"en": "Peter's son", "pt": "O filho de Pedro"},
				{"en": "Jairus' son", "pt": "O filho de Jairo"},
				{"en": "A priest's son", "pt": "O filho de um sacerdote"}
			]
		},
		{
			"question":
			{
				"en": "Who was raised after four days in the tomb?",
				"pt": "Quem foi levantado apos quatro dias no tumulo?"
			},
			"answer": {"en": "Lazarus", "pt": "Lazaro"},
			"tier": 3,
			"decoys":
			[
				{"en": "Jairus' daughter", "pt": "A filha de Jairo"},
				{"en": "Widow's son at Nain", "pt": "O filho da viuva de Naim"},
				{"en": "Tabitha", "pt": "Tabita"}
			]
		},
		{
			"question":
			{
				"en": "Where did Jesus find the coin to pay the temple tax?",
				"pt": "Onde Jesus encontrou a moeda para pagar o imposto do templo?"
			},
			"answer": {"en": "In a fish's mouth", "pt": "Na boca de um peixe"},
			"tier": 3,
			"decoys":
			[
				{"en": "In Judas' purse", "pt": "Na bolsa de Judas"},
				{"en": "From the temple treasury", "pt": "Do tesouro do templo"},
				{"en": "Given by Nicodemus", "pt": "Dada por Nicodemos"}
			]
		},
		{
			"question":
			{
				"en": "When did the nets nearly break with a miraculous catch of fish?",
				"pt": "Quando as redes quase se romperam com uma pesca milagrosa?"
			},
			"answer":
			{
				"en": "At the calling of Peter and partners",
				"pt": "Na chamada de Pedro e companheiros"
			},
			"tier": 3,
			"decoys":
			[
				{"en": "After the Sermon on the Mount", "pt": "Depois do Sermao do Monte"},
				{"en": "At the wedding in Cana", "pt": "No casamento em Cana"},
				{"en": "During the Passover in Jerusalem", "pt": "Durante a Pascoa em Jerusalem"}
			]
		},
		{
			"question":
			{
				"en": "After the resurrection, when did Jesus fill the nets with 153 fish?",
				"pt": "Apos a ressurreicao, quando Jesus encheu as redes com 153 peixes?"
			},
			"answer":
			{"en": "On the Sea of Galilee at daybreak", "pt": "No Mar da Galileia ao amanhecer"},
			"tier": 3,
			"decoys":
			[
				{"en": "During the Sermon on the Mount", "pt": "Durante o Sermao do Monte"},
				{"en": "On the road to Emmaus", "pt": "No caminho de Emaus"},
				{"en": "At a dinner in Bethany", "pt": "Num jantar em Betania"}
			]
		},
		{
			"question":
			{
				"en": "What tree withered after Jesus spoke to it?",
				"pt": "Que arvore secou depois que Jesus falou com ela?"
			},
			"answer": {"en": "A fig tree", "pt": "Uma figueira"},
			"tier": 3,
			"decoys":
			[
				{"en": "A mulberry tree", "pt": "Uma amoreira"},
				{"en": "A cedar tree", "pt": "Um cedro"},
				{"en": "A palm tree", "pt": "Uma palmeira"}
			]
		},
		{
			"question":
			{
				"en": "Whose ear did Jesus heal in Gethsemane?",
				"pt": "De quem Jesus curou a orelha no Getsemani?"
			},
			"answer": {"en": "Malchus", "pt": "Malco"},
			"tier": 3,
			"decoys":
			[
				{"en": "Barabbas", "pt": "Barrabas"},
				{"en": "A Roman centurion", "pt": "Um centuriao romano"},
				{"en": "Simon the Zealot", "pt": "Simao o Zelote"}
			]
		},
		{
			"question":
			{
				"en": "Who was raised when Jesus met a funeral procession at Nain?",
				"pt": "Quem foi levantado quando Jesus encontrou um cortejo funebre em Naim?"
			},
			"answer": {"en": "A widow's only son", "pt": "O unico filho de uma viuva"},
			"tier": 3,
			"decoys":
			[
				{"en": "Eutychus", "pt": "Eutico"},
				{"en": "Tabitha", "pt": "Tabita"},
				{"en": "The Shunammite's son", "pt": "O filho da sunamita"}
			]
		},
		{
			"question":
			{
				"en": "Who was straightened after being bent for eighteen years?",
				"pt": "Quem foi endireitada apos ficar curvada por dezoito anos?"
			},
			"answer":
			{"en": "A crippled woman in a synagogue", "pt": "Uma mulher encurvada na sinagoga"},
			"tier": 3,
			"decoys":
			[
				{"en": "The Samaritan woman", "pt": "A mulher samaritana"},
				{"en": "The bleeding woman", "pt": "A mulher com fluxo de sangue"},
				{"en": "A widow who gave two coins", "pt": "A viuva das duas moedas"}
			]
		},
		{
			"question":
			{
				"en": "Whom did Jesus heal of dropsy at a Pharisee's house?",
				"pt": "Quem Jesus curou de hidropisia na casa de um fariseu?"
			},
			"answer": {"en": "A man with dropsy", "pt": "Um homem com hidropisia"},
			"tier": 3,
			"decoys":
			[
				{"en": "A leper in Galilee", "pt": "Um leproso na Galileia"},
				{"en": "A blind man in Jericho", "pt": "Um cego em Jerico"},
				{"en": "A lame beggar at the gate", "pt": "Um mendigo coxo no portao"}
			]
		},
		{
			"question":
			{
				"en": "Which miracle freed a mute man to speak after a demon was cast out?",
				"pt":
				"Qual milagre libertou um homem mudo para falar depois que um demonio foi expulso?"
			},
			"answer": {"en": "Jesus cast out a mute demon", "pt": "Jesus expulsou um demonio mudo"},
			"tier": 3,
			"decoys":
			[
				{"en": "He healed ten lepers", "pt": "Curou dez leprosos"},
				{
					"en": "He opened deaf ears in Decapolis",
					"pt": "Abriu ouvidos surdos na Decapole"
				},
				{"en": "He calmed a storm on the lake", "pt": "Acalmou uma tempestade no lago"}
			]
		}
	],
	"Parables of Jesus":
	[
		{
			"question":
			{
				"en": "Who helped the wounded man in the parable on the road to Jericho?",
				"pt": "Quem ajudou o homem ferido na parábola no caminho para Jericó?"
			},
			"answer": {"en": "The Good Samaritan", "pt": "O Bom Samaritano"},
			"tier": 1,
			"decoys":
			[
				{"en": "A priest", "pt": "Um padre"},
				{"en": "A Levite", "pt": "Um levita"},
				{"en": "An innkeeper", "pt": "Um estalajadeiro"}
			]
		},
		{
			"question":
			{
				"en": "Which parable tells of a wayward son welcomed home?",
				"pt": "Qual parábola fala de um filho rebelde recebido em casa?"
			},
			"answer": {"en": "The Prodigal Son", "pt": "O filho pródigo"},
			"tier": 1,
			"decoys":
			[
				{"en": "The Lost Coin", "pt": "A moeda perdida"},
				{"en": "The Lost Sheep", "pt": "A ovelha perdida"},
				{"en": "The Two Debtors", "pt": "Os dois devedores"}
			]
		},
		{
			"question":
			{
				"en": "What tiny seed grows into a great plant in Jesus' teaching?",
				"pt":
				"Que pequena semente se transforma numa grande planta nos ensinamentos de Jesus?"
			},
			"answer": {"en": "The mustard seed", "pt": "A semente de mostarda"},
			"tier": 1,
			"decoys":
			[
				{"en": "The wheat seed", "pt": "A semente de trigo"},
				{"en": "The fig seed", "pt": "A semente de figo"},
				{"en": "The olive seed", "pt": "A semente de oliveira"}
			]
		},
		{
			"question":
			{
				"en": "Which parable speaks of seed on four types of soil?",
				"pt": "Qual parábola fala de sementes em quatro tipos de solo?"
			},
			"answer": {"en": "The Parable of the Sower", "pt": "A Parábola do Semeador"},
			"tier": 1,
			"decoys":
			[
				{"en": "The Wheat and Tares", "pt": "O trigo e o joio"},
				{"en": "The Growing Seed", "pt": "A semente crescente"},
				{"en": "The Vineyard Tenants", "pt": "Os inquilinos da vinha"}
			]
		},
		{
			"question":
			{
				"en": "Who leaves ninety-nine sheep to find one?",
				"pt": "Quem deixa noventa e nove ovelhas para encontrar uma?"
			},
			"answer":
			{
				"en": "The shepherd in the Lost Sheep parable",
				"pt": "O pastor na parábola da ovelha perdida"
			},
			"tier": 1,
			"decoys":
			[
				{"en": "The vineyard owner", "pt": "O dono da vinha"},
				{"en": "The prodigal's father", "pt": "O pai do pródigo"},
				{"en": "The merchant of pearls", "pt": "O comerciante de pérolas"}
			]
		},
		{
			"question":
			{
				"en": "Which parable contrasts a house built on rock with one on sand?",
				"pt": "Qual parábola contrasta uma casa construída na rocha com outra na areia?"
			},
			"answer":
			{"en": "The Wise and Foolish Builders", "pt": "Os Construtores Sábios e Tolos"},
			"tier": 1,
			"decoys":
			[
				{"en": "The Rich Fool", "pt": "O rico tolo"},
				{"en": "The Talents", "pt": "Os Talentos"},
				{"en": "The Ten Virgins", "pt": "As Dez Virgens"}
			]
		},
		{
			"question":
			{
				"en": "Which parable warns a man who planned bigger barns for his crops?",
				"pt":
				"Qual parábola alerta um homem que planejou celeiros maiores para suas plantações?"
			},
			"answer": {"en": "The Rich Fool", "pt": "O rico tolo"},
			"tier": 2,
			"decoys":
			[
				{"en": "The Good Samaritan", "pt": "O Bom Samaritano"},
				{"en": "The Prodigal Son", "pt": "O filho pródigo"},
				{"en": "The Unjust Steward", "pt": "O administrador injusto"}
			]
		},
		{
			"question":
			{
				"en": "Which parable tells of wheat and weeds growing together until harvest?",
				"pt": "Qual parábola fala do trigo e do joio crescendo juntos até a colheita?"
			},
			"answer": {"en": "The Wheat and Tares", "pt": "O trigo e o joio"},
			"tier": 2,
			"decoys":
			[
				{"en": "The Sower", "pt": "O Semeador"},
				{"en": "The Net", "pt": "A rede"},
				{"en": "The Lost Coin", "pt": "A moeda perdida"}
			]
		},
		{
			"question":
			{
				"en": "Which parable says the kingdom is like yeast mixed into dough?",
				"pt": "Qual parábola diz que o reino é como fermento misturado à massa?"
			},
			"answer": {"en": "The Parable of the Leaven", "pt": "A parábola do fermento"},
			"tier": 2,
			"decoys":
			[
				{"en": "The Mustard Seed", "pt": "A semente de mostarda"},
				{"en": "The Hidden Treasure", "pt": "O Tesouro Escondido"},
				{"en": "The Pearl of Great Price", "pt": "A Pérola de Grande Valor"}
			]
		},
		{
			"question":
			{
				"en": "Which parable speaks of treasure hidden in a field?",
				"pt": "Qual parábola fala de um tesouro escondido num campo?"
			},
			"answer": {"en": "The Hidden Treasure", "pt": "O Tesouro Escondido"},
			"tier": 1,
			"decoys":
			[
				{"en": "The Pearl of Great Price", "pt": "A Pérola de Grande Valor"},
				{"en": "The Lost Coin", "pt": "A moeda perdida"},
				{"en": "The Talents", "pt": "Os Talentos"}
			]
		},
		{
			"question":
			{
				"en": "Which parable tells of a merchant seeking fine gems?",
				"pt": "Qual parábola fala de um comerciante que procurava joias finas?"
			},
			"answer": {"en": "The Pearl of Great Price", "pt": "A Pérola de Grande Valor"},
			"tier": 1,
			"decoys":
			[
				{"en": "The Hidden Treasure", "pt": "O Tesouro Escondido"},
				{"en": "The Lost Sheep", "pt": "A ovelha perdida"},
				{"en": "The Great Banquet", "pt": "O Grande Banquete"}
			]
		},
		{
			"question":
			{
				"en":
				"Which parable describes workers hired at different hours receiving the same wage?",
				"pt":
				"Qual parábola descreve trabalhadores contratados em horários diferentes recebendo o mesmo salário?"
			},
			"answer": {"en": "The Workers in the Vineyard", "pt": "Os trabalhadores da vinha"},
			"tier": 2,
			"decoys":
			[
				{"en": "The Prodigal Son", "pt": "O filho pródigo"},
				{"en": "The Two Sons", "pt": "Os dois filhos"},
				{"en": "The Wedding Feast", "pt": "A festa de casamento"}
			]
		},
		{
			"question":
			{
				"en": "Which parable tells of lamps, oil, and bridesmaids waiting?",
				"pt": "Qual parábola fala de lâmpadas, óleo e damas de honra esperando?"
			},
			"answer": {"en": "The Ten Virgins", "pt": "As Dez Virgens"},
			"tier": 2,
			"decoys":
			[
				{"en": "The Talents", "pt": "Os Talentos"},
				{"en": "The Sheep and Goats", "pt": "As ovelhas e cabras"},
				{"en": "The Wedding Banquet", "pt": "O banquete de casamento"}
			]
		},
		{
			"question":
			{
				"en":
				"Which parable features servants entrusted with sums while the master travels?",
				"pt":
				"Qual parábola apresenta servos a quem foram confiadas somas enquanto o senhor viaja?"
			},
			"answer": {"en": "The Parable of the Talents", "pt": "A Parábola dos Talentos"},
			"tier": 2,
			"decoys":
			[
				{"en": "The Minas", "pt": "As Minas"},
				{"en": "The Ten Virgins", "pt": "As Dez Virgens"},
				{"en": "The Sower", "pt": "O Semeador"}
			]
		},
		{
			"question":
			{
				"en": "Which parable shows a widow persisting before an unjust judge?",
				"pt": "Qual parábola mostra uma viúva persistindo diante de um juiz injusto?"
			},
			"answer": {"en": "The Persistent Widow", "pt": "A viúva persistente"},
			"tier": 2,
			"decoys":
			[
				{"en": "The Friend at Midnight", "pt": "O amigo da meia-noite"},
				{"en": "The Rich Man and Lazarus", "pt": "O Rico e Lázaro"},
				{
					"en": "The Pharisee and the Tax Collector",
					"pt": "O fariseu e o cobrador de impostos"
				}
			]
		},
		{
			"question":
			{
				"en": "Which parable contrasts a proud worshiper and a repentant tax collector?",
				"pt":
				"Qual parábola contrasta um adorador orgulhoso e um cobrador de impostos arrependido?"
			},
			"answer":
			{
				"en": "The Pharisee and the Tax Collector",
				"pt": "O fariseu e o cobrador de impostos"
			},
			"tier": 1,
			"decoys":
			[
				{"en": "The Prodigal Son", "pt": "O filho pródigo"},
				{"en": "The Two Debtors", "pt": "Os dois devedores"},
				{"en": "The Good Samaritan", "pt": "O Bom Samaritano"}
			]
		},
		{
			"question":
			{
				"en":
				"Which parable has one son who said no then obeyed, and another who said yes but did not?",
				"pt":
				"Em qual parábola um filho que disse não obedeceu e outro que disse sim, mas não obedeceu?"
			},
			"answer": {"en": "The Parable of the Two Sons", "pt": "A parábola dos dois filhos"},
			"tier": 2,
			"decoys":
			[
				{"en": "The Prodigal Son", "pt": "O filho pródigo"},
				{"en": "The Lost Coin", "pt": "A moeda perdida"},
				{"en": "The Unforgiving Servant", "pt": "O servo implacável"}
			]
		},
		{
			"question":
			{
				"en": "Which parable likens the kingdom to a dragnet sorting good fish from bad?",
				"pt":
				"Qual parábola compara o reino a uma rede que separa os peixes bons dos ruins?"
			},
			"answer": {"en": "The Parable of the Net", "pt": "A parábola da rede"},
			"tier": 3,
			"decoys":
			[
				{"en": "The Wheat and Tares", "pt": "O trigo e o joio"},
				{"en": "The Mustard Seed", "pt": "A semente de mostarda"},
				{"en": "The Good Shepherd", "pt": "O bom pastor"}
			]
		},
		{
			"question":
			{
				"en": "Which parable describes a neighbor knocking late at night for bread?",
				"pt": "Qual parábola descreve um vizinho batendo tarde da noite para pedir pão?"
			},
			"answer": {"en": "The Friend at Midnight", "pt": "O amigo da meia-noite"},
			"tier": 2,
			"decoys":
			[
				{"en": "The Persistent Widow", "pt": "A viúva persistente"},
				{"en": "The Ten Virgins", "pt": "As Dez Virgens"},
				{"en": "The Unjust Steward", "pt": "O administrador injusto"}
			]
		},
		{
			"question":
			{
				"en": "Which parable portrays a king separating nations like sheep and goats?",
				"pt": "Qual parábola retrata um rei separando nações como ovelhas e cabras?"
			},
			"answer": {"en": "The Sheep and the Goats", "pt": "As ovelhas e as cabras"},
			"tier": 2,
			"decoys":
			[
				{"en": "The Lost Sheep", "pt": "A ovelha perdida"},
				{"en": "The Good Shepherd", "pt": "O bom pastor"},
				{"en": "The Net", "pt": "A rede"}
			]
		},
		{
			"question":
			{
				"en": "Which parable features a woman who rejoices after finding a lost coin?",
				"pt": "Which parable features a woman who rejoices after finding a lost coin?"
			},
			"answer": {"en": "Parable of the Lost Coin", "pt": "Parable of the Lost Coin"},
			"tier": 1,
			"decoys":
			[
				{"en": "Parable of the Lost Sheep", "pt": "Parable of the Lost Sheep"},
				{"en": "Parable of the Hidden Treasure", "pt": "Parable of the Hidden Treasure"},
				{"en": "Parable of the Pearl", "pt": "Parable of the Pearl"}
			]
		},
		{
			"question":
			{
				"en": "Which parable tells of a manager praised for shrewdly reducing debts?",
				"pt": "Which parable tells of a manager praised for shrewdly reducing debts?"
			},
			"answer":
			{"en": "Parable of the Unjust Steward", "pt": "Parable of the Unjust Steward"},
			"tier": 3,
			"decoys":
			[
				{"en": "Parable of the Talents", "pt": "Parable of the Talents"},
				{"en": "Parable of the Two Debtors", "pt": "Parable of the Two Debtors"},
				{"en": "Parable of the Two Sons", "pt": "Parable of the Two Sons"}
			]
		},
		{
			"question":
			{
				"en":
				"Which parable contrasts a rich man in torment and a beggar at Abraham's side?",
				"pt":
				"Which parable contrasts a rich man in torment and a beggar at Abraham's side?"
			},
			"answer":
			{
				"en": "Parable of the Rich Man and Lazarus",
				"pt": "Parable of the Rich Man and Lazarus"
			},
			"tier": 3,
			"decoys":
			[
				{"en": "Parable of the Wedding Banquet", "pt": "Parable of the Wedding Banquet"},
				{"en": "Parable of the Ten Virgins", "pt": "Parable of the Ten Virgins"},
				{"en": "Parable of the Prodigal Son", "pt": "Parable of the Prodigal Son"}
			]
		},
		{
			"question":
			{
				"en": "Which parable pictures guests refusing a banquet so outsiders are invited?",
				"pt": "Which parable pictures guests refusing a banquet so outsiders are invited?"
			},
			"answer": {"en": "Parable of the Great Banquet", "pt": "Parable of the Great Banquet"},
			"tier": 3,
			"decoys":
			[
				{"en": "Parable of the Ten Virgins", "pt": "Parable of the Ten Virgins"},
				{"en": "Parable of the Talents", "pt": "Parable of the Talents"},
				{"en": "Parable of the Two Sons", "pt": "Parable of the Two Sons"}
			]
		},
		{
			"question":
			{
				"en": "Which parable warns of a tree given one more year before being cut down?",
				"pt": "Which parable warns of a tree given one more year before being cut down?"
			},
			"answer":
			{"en": "Parable of the Barren Fig Tree", "pt": "Parable of the Barren Fig Tree"},
			"tier": 3,
			"decoys":
			[
				{"en": "Parable of the Mustard Seed", "pt": "Parable of the Mustard Seed"},
				{"en": "Parable of the Two Builders", "pt": "Parable of the Two Builders"},
				{"en": "Parable of the Hidden Treasure", "pt": "Parable of the Hidden Treasure"}
			]
		},
		{
			"question":
			{
				"en":
				"Which parable shows one debtor owing five hundred denarii and another fifty?",
				"pt": "Which parable shows one debtor owing five hundred denarii and another fifty?"
			},
			"answer": {"en": "Parable of the Two Debtors", "pt": "Parable of the Two Debtors"},
			"tier": 3,
			"decoys":
			[
				{
					"en": "Parable of the Unforgiving Servant",
					"pt": "Parable of the Unforgiving Servant"
				},
				{"en": "Parable of the Two Sons", "pt": "Parable of the Two Sons"},
				{"en": "Parable of the Sower", "pt": "Parable of the Sower"}
			]
		},
		{
			"question":
			{
				"en": "Which parable describes seed growing secretly until the harvest?",
				"pt": "Which parable describes seed growing secretly until the harvest?"
			},
			"answer": {"en": "Parable of the Growing Seed", "pt": "Parable of the Growing Seed"},
			"tier": 3,
			"decoys":
			[
				{"en": "Parable of the Mustard Seed", "pt": "Parable of the Mustard Seed"},
				{"en": "Parable of the Wheat and Weeds", "pt": "Parable of the Wheat and Weeds"},
				{"en": "Parable of the Fig Tree", "pt": "Parable of the Fig Tree"}
			]
		},
		{
			"question":
			{
				"en": "Which parable has servants trading ten minas while the nobleman travels?",
				"pt": "Which parable has servants trading ten minas while the nobleman travels?"
			},
			"answer": {"en": "Parable of the Ten Minas", "pt": "Parable of the Ten Minas"},
			"tier": 3,
			"decoys":
			[
				{"en": "Parable of the Talents", "pt": "Parable of the Talents"},
				{"en": "Parable of the Faithful Servant", "pt": "Parable of the Faithful Servant"},
				{"en": "Parable of the Lost Sheep", "pt": "Parable of the Lost Sheep"}
			]
		},
		{
			"question":
			{
				"en":
				"Which parable urges readiness like a master returning to find servants watching?",
				"pt":
				"Which parable urges readiness like a master returning to find servants watching?"
			},
			"answer":
			{
				"en": "Parable of the Faithful and Wicked Servant",
				"pt": "Parable of the Faithful and Wicked Servant"
			},
			"tier": 3,
			"decoys":
			[
				{"en": "Parable of the Ten Virgins", "pt": "Parable of the Ten Virgins"},
				{"en": "Parable of the Two Sons", "pt": "Parable of the Two Sons"},
				{"en": "Parable of the Sower", "pt": "Parable of the Sower"}
			]
		},
		{
			"question":
			{
				"en": "Which parable teaches counting the cost like a builder or king before war?",
				"pt": "Which parable teaches counting the cost like a builder or king before war?"
			},
			"answer": {"en": "Parable of Counting the Cost", "pt": "Parable of Counting the Cost"},
			"tier": 3,
			"decoys":
			[
				{"en": "Parable of the Pearl", "pt": "Parable of the Pearl"},
				{"en": "Parable of the Hidden Treasure", "pt": "Parable of the Hidden Treasure"},
				{"en": "Parable of the Unjust Judge", "pt": "Parable of the Unjust Judge"}
			]
		}
	],
	"Teachings of Jesus":
	[
		{
			"question":
			{
				"en": "What prayer did Jesus teach beginning 'Our Father'?",
				"pt": "Que oração Jesus ensinou começando com 'Pai Nosso'?"
			},
			"answer": {"en": "The Lord's Prayer", "pt": "A oração do Pai Nosso"},
			"tier": 1,
			"decoys":
			[
				{"en": "The Shema", "pt": "O Shemá"},
				{"en": "The Apostles' Creed", "pt": "O Credo dos Apóstolos"},
				{"en": "The High Priestly Prayer", "pt": "A oração do Sumo Sacerdote"}
			]
		},
		{
			"question":
			{
				"en": "What rule summarizes the Law and prophets about treating others?",
				"pt": "Que regra resume a Lei e os profetas sobre como tratar os outros?"
			},
			"answer": {"en": "The Golden Rule", "pt": "A regra de ouro"},
			"tier": 1,
			"decoys":
			[
				{"en": "The Silver Rule", "pt": "A regra de prata"},
				{"en": "The Jubilee Law", "pt": "A Lei do Jubileu"},
				{"en": "An eye for an eye", "pt": "Olho por olho"}
			]
		},
		{
			"question":
			{
				"en": "What sermon includes the Beatitudes?",
				"pt": "Que sermão inclui as bem-aventuranças?"
			},
			"answer": {"en": "The Sermon on the Mount", "pt": "O Sermão da Montanha"},
			"tier": 1,
			"decoys":
			[
				{"en": "Sermon on the Plain", "pt": "Sermão na Planície"},
				{"en": "Upper Room Discourse", "pt": "Discurso do Cenáculo"},
				{"en": "Olivet Discourse", "pt": "Discurso do Monte das Oliveiras"}
			]
		},
		{
			"question":
			{
				"en": "What did Jesus call the greatest commandment?",
				"pt": "O que Jesus chamou de maior mandamento?"
			},
			"answer":
			{"en": "Love God with all your heart", "pt": "Ame a Deus de todo o seu coração"},
			"tier": 1,
			"decoys":
			[
				{"en": "Keep the Sabbath holy", "pt": "Guarde o sábado santo"},
				{"en": "Honor parents", "pt": "Honre os pais"},
				{"en": "Do not murder", "pt": "Não mate"}
			]
		},
		{
			"question":
			{
				"en": "What did Jesus say about loving neighbors?",
				"pt": "O que Jesus disse sobre amar o próximo?"
			},
			"answer":
			{"en": "Love your neighbor as yourself", "pt": "Ame o seu próximo como a si mesmo"},
			"tier": 1,
			"decoys":
			[
				{
					"en": "Love your neighbor if they love you",
					"pt": "Ame o seu próximo se ele te ama"
				},
				{"en": "Avoid your enemies", "pt": "Evite seus inimigos"},
				{"en": "Pray only for friends", "pt": "Ore apenas pelos amigos"}
			]
		},
		{
			"question":
			{
				"en": "What did Jesus say to seek first before worrying about needs?",
				"pt":
				"O que Jesus disse para procurarmos primeiro antes de nos preocuparmos com as necessidades?"
			},
			"answer":
			{
				"en": "The kingdom of God and His righteousness",
				"pt": "O reino de Deus e Sua justiça"
			},
			"tier": 3,
			"decoys":
			[
				{"en": "A secure job", "pt": "Um trabalho seguro"},
				{"en": "The praise of people", "pt": "O elogio das pessoas"},
				{"en": "Extra barns and storehouses", "pt": "Celeiros e armazéns extras"}
			]
		},
		{
			"question":
			{
				"en": "How did Jesus say to treat enemies?",
				"pt": "Como Jesus disse para tratar os inimigos?"
			},
			"answer":
			{
				"en": "Love your enemies and pray for those who persecute you",
				"pt": "Amai os vossos inimigos e rezai por aqueles que vos perseguem"
			},
			"tier": 1,
			"decoys":
			[
				{"en": "Ignore them", "pt": "Ignore-os"},
				{"en": "Fight them", "pt": "Lute contra eles"},
				{"en": "Avoid them on the Sabbath", "pt": "Evite-os no sábado"}
			]
		},
		{
			"question":
			{
				"en": "What did Jesus teach about serving two masters?",
				"pt": "O que Jesus ensinou sobre servir a dois senhores?"
			},
			"answer":
			{
				"en": "No one can serve both God and money",
				"pt": "Ninguém pode servir a Deus e ao dinheiro"
			},
			"tier": 3,
			"decoys":
			[
				{"en": "Masters must agree", "pt": "Os mestres devem concordar"},
				{"en": "Service alternates weekly", "pt": "O serviço alterna semanalmente"},
				{"en": "Masters divide the tithe", "pt": "Mestres dividem o dízimo"}
			]
		},
		{
			"question":
			{
				"en": "When asked about taxes, what did Jesus say to give Caesar?",
				"pt": "Quando questionado sobre impostos, o que Jesus disse para dar a César?"
			},
			"answer":
			{
				"en": "Render to Caesar the things that are Caesar's",
				"pt": "Dê a César o que é de César"
			},
			"tier": 1,
			"decoys":
			[
				{"en": "Refuse to pay", "pt": "Recuse-se a pagar"},
				{"en": "Everything belongs to God alone", "pt": "Tudo pertence somente a Deus"},
				{"en": "Only temple money counts", "pt": "Somente o dinheiro do templo conta"}
			]
		},
		{
			"question":
			{
				"en": "What did Jesus say disciples must take up to follow Him?",
				"pt": "O que Jesus disse que os discípulos devem aprender para segui-Lo?"
			},
			"answer": {"en": "Their cross", "pt": "A cruz deles"},
			"tier": 3,
			"decoys":
			[
				{"en": "A sword", "pt": "Uma espada"},
				{"en": "A staff of office", "pt": "Uma equipe de escritório"},
				{"en": "A bag of coins", "pt": "Um saco de moedas"}
			]
		},
		{
			"question":
			{
				"en": "How did Jesus define greatness among His followers?",
				"pt": "Como Jesus definiu a grandeza entre Seus seguidores?"
			},
			"answer":
			{
				"en": "Whoever wants to be great must be a servant",
				"pt": "Quem quiser ser grande deve ser servo"
			},
			"tier": 1,
			"decoys":
			[
				{"en": "The strongest is greatest", "pt": "O mais forte é o maior"},
				{"en": "Only the eldest is greatest", "pt": "Só o mais velho é maior"},
				{"en": "The most learned is greatest", "pt": "O mais aprendido é o maior"}
			]
		},
		{
			"question":
			{
				"en": "What did Jesus call Himself after feeding the crowds?",
				"pt": "Como Jesus se chamou depois de alimentar as multidões?"
			},
			"answer": {"en": "The bread of life", "pt": "O pão da vida"},
			"tier": 2,
			"decoys":
			[
				{"en": "The living water", "pt": "A água viva"},
				{"en": "The door", "pt": "A porta"},
				{"en": "The true vine", "pt": "A verdadeira videira"}
			]
		},
		{
			"question":
			{
				"en":
				"What did Jesus call Himself when saying followers would not walk in darkness?",
				"pt": "Como Jesus se chamou ao dizer que os seguidores não andariam nas trevas?"
			},
			"answer": {"en": "The light of the world", "pt": "A luz do mundo"},
			"tier": 2,
			"decoys":
			[
				{"en": "The bright morning star", "pt": "A brilhante estrela da manhã"},
				{"en": "The lampstand", "pt": "O candelabro"},
				{"en": "The torch of Zion", "pt": "A tocha de Sião"}
			]
		},
		{
			"question":
			{
				"en": "How did Jesus describe the way to the Father?",
				"pt": "Como Jesus descreveu o caminho para o Pai?"
			},
			"answer":
			{
				"en": "I am the way, the truth, and the life",
				"pt": "Eu sou o caminho, a verdade e a vida"
			},
			"tier": 2,
			"decoys":
			[
				{"en": "Follow the commandments alone", "pt": "Siga os mandamentos sozinho"},
				{"en": "Find your own path", "pt": "Encontre seu próprio caminho"},
				{"en": "Offer daily sacrifices", "pt": "Ofereça sacrifícios diários"}
			]
		},
		{
			"question":
			{
				"en": "What did Jesus call Himself in relation to His sheep?",
				"pt": "Como Jesus se chamou em relação às Suas ovelhas?"
			},
			"answer": {"en": "The good shepherd", "pt": "O bom pastor"},
			"tier": 1,
			"decoys":
			[
				{"en": "The hired hand", "pt": "A mão contratada"},
				{"en": "The gatekeeper only", "pt": "Somente o porteiro"},
				{"en": "The vineyard master", "pt": "O mestre da vinha"}
			]
		},
		{
			"question":
			{
				"en": "What did Jesus say branches must do to bear fruit?",
				"pt": "O que Jesus disse que os ramos devem fazer para dar frutos?"
			},
			"answer": {"en": "Abide in the vine", "pt": "Permaneça na videira"},
			"tier": 2,
			"decoys":
			[
				{"en": "Stand alone bravely", "pt": "Fique sozinho com bravura"},
				{"en": "Grow in rocky soil", "pt": "Crescer em solo rochoso"},
				{"en": "Cut themselves back often", "pt": "Corte-se frequentemente"}
			]
		},
		{
			"question":
			{
				"en": "According to Jesus, what truly makes a person unclean?",
				"pt": "Segundo Jesus, o que realmente torna uma pessoa impura?"
			},
			"answer": {"en": "What comes out of the heart", "pt": "O que sai do coração"},
			"tier": 2,
			"decoys":
			[
				{"en": "Not washing hands", "pt": "Não lavar as mãos"},
				{"en": "Eating food with sinners", "pt": "Comer comida com pecadores"},
				{"en": "Touching a leper", "pt": "Tocar um leproso"}
			]
		},
		{
			"question":
			{
				"en": "What did Jesus tell Nicodemus must happen to see God's kingdom?",
				"pt":
				"O que Jesus disse a Nicodemos que deveria acontecer para ver o reino de Deus?"
			},
			"answer": {"en": "You must be born again", "pt": "Você deve nascer de novo"},
			"tier": 2,
			"decoys":
			[
				{"en": "Offer a spotless lamb", "pt": "Ofereça um cordeiro impecável"},
				{
					"en": "Keep every tradition flawlessly",
					"pt": "Mantenha todas as tradições perfeitamente"
				},
				{"en": "Become a priest", "pt": "Torne-se um padre"}
			]
		},
		{
			"question":
			{
				"en": "Where did Jesus say to store treasure?",
				"pt": "Onde Jesus disse para guardar tesouros?"
			},
			"answer": {"en": "Lay up treasures in heaven", "pt": "Acumule tesouros no céu"},
			"tier": 1,
			"decoys":
			[
				{"en": "Build bigger barns", "pt": "Construa celeiros maiores"},
				{"en": "Hide it in the field", "pt": "Esconda-o no campo"},
				{
					"en": "Store it with the temple moneychangers",
					"pt": "Guarde-o com os cambistas do templo"
				}
			]
		},
		{
			"question":
			{
				"en": "What sign did Jesus say would be given to a wicked generation?",
				"pt": "Que sinal Jesus disse que seria dado a uma geração iníqua?"
			},
			"answer": {"en": "The sign of Jonah", "pt": "O sinal de Jonas"},
			"tier": 3,
			"decoys":
			[
				{"en": "Fire from heaven", "pt": "Fogo do céu"},
				{"en": "A new temple", "pt": "Um novo templo"},
				{"en": "Three more plagues", "pt": "Mais três pragas"}
			]
		},
		{
			"question":
			{
				"en": "How many times did Jesus say to forgive a brother who sins?",
				"pt": "How many times did Jesus say to forgive a brother who sins?"
			},
			"answer": {"en": "Seventy-seven times", "pt": "Seventy-seven times"},
			"tier": 2,
			"decoys":
			[
				{"en": "Seven times", "pt": "Seven times"},
				{"en": "Ten times", "pt": "Ten times"},
				{"en": "Three times", "pt": "Three times"}
			]
		},
		{
			"question":
			{
				"en": "What did Jesus say about the gate that leads to life?",
				"pt": "What did Jesus say about the gate that leads to life?"
			},
			"answer": {"en": "It is narrow and few find it", "pt": "It is narrow and few find it"},
			"tier": 2,
			"decoys":
			[
				{"en": "It is wide and easy", "pt": "It is wide and easy"},
				{"en": "It is hidden under a field", "pt": "It is hidden under a field"},
				{"en": "It is guarded by angels", "pt": "It is guarded by angels"}
			]
		},
		{
			"question":
			{
				"en": "What did Jesus say to do when you give to the needy?",
				"pt": "What did Jesus say to do when you give to the needy?"
			},
			"answer":
			{
				"en": "Give in secret and not announce it",
				"pt": "Give in secret and not announce it"
			},
			"tier": 2,
			"decoys":
			[
				{"en": "Give only in the temple", "pt": "Give only in the temple"},
				{"en": "Give only to relatives", "pt": "Give only to relatives"},
				{
					"en": "Tell your left hand what your right hand gives",
					"pt": "Tell your left hand what your right hand gives"
				}
			]
		},
		{
			"question":
			{
				"en": "What did Jesus say humans should live on besides bread?",
				"pt": "What did Jesus say humans should live on besides bread?"
			},
			"answer":
			{"en": "Every word that comes from God", "pt": "Every word that comes from God"},
			"tier": 2,
			"decoys":
			[
				{"en": "Every harvest offered", "pt": "Every harvest offered"},
				{"en": "Fish from the sea", "pt": "Fish from the sea"},
				{"en": "Oil and wine", "pt": "Oil and wine"}
			]
		},
		{
			"question":
			{
				"en": "What sin did Jesus warn would not be forgiven?",
				"pt": "What sin did Jesus warn would not be forgiven?"
			},
			"answer":
			{"en": "Blasphemy against the Holy Spirit", "pt": "Blasphemy against the Holy Spirit"},
			"tier": 3,
			"decoys":
			[
				{"en": "Doubting Thomas", "pt": "Doubting Thomas"},
				{"en": "Asking for a sign", "pt": "Asking for a sign"},
				{"en": "Breaking the Sabbath", "pt": "Breaking the Sabbath"}
			]
		},
		{
			"question":
			{
				"en": "What did Jesus say to do if your right eye causes you to sin?",
				"pt": "What did Jesus say to do if your right eye causes you to sin?"
			},
			"answer":
			{"en": "Gouge it out and throw it away", "pt": "Gouge it out and throw it away"},
			"tier": 3,
			"decoys":
			[
				{"en": "Cover it for seven days", "pt": "Cover it for seven days"},
				{"en": "Wash it in Siloam", "pt": "Wash it in Siloam"},
				{"en": "Pray with both eyes closed", "pt": "Pray with both eyes closed"}
			]
		},
		{
			"question":
			{
				"en": "What did Jesus teach about divorce?",
				"pt": "What did Jesus teach about divorce?"
			},
			"answer":
			{
				"en": "Anyone who divorces his wife except for sexual immorality causes adultery",
				"pt": "Anyone who divorces his wife except for sexual immorality causes adultery"
			},
			"tier": 3,
			"decoys":
			[
				{"en": "Divorce is always acceptable", "pt": "Divorce is always acceptable"},
				{"en": "Only widows may remarry", "pt": "Only widows may remarry"},
				{"en": "Marriage vows are optional", "pt": "Marriage vows are optional"}
			]
		},
		{
			"question":
			{
				"en": "What did Jesus predict about the temple buildings?",
				"pt": "What did Jesus predict about the temple buildings?"
			},
			"answer":
			{
				"en": "Not one stone would be left on another",
				"pt": "Not one stone would be left on another"
			},
			"tier": 3,
			"decoys":
			[
				{"en": "They would shine forever", "pt": "They would shine forever"},
				{"en": "They would be taller", "pt": "They would be taller"},
				{"en": "They would move to Bethlehem", "pt": "They would move to Bethlehem"}
			]
		},
		{
			"question":
			{
				"en": "What did Jesus say about hating father and mother compared to loving Him?",
				"pt": "What did Jesus say about hating father and mother compared to loving Him?"
			},
			"answer":
			{
				"en": "Anyone who does not hate them compared to Him cannot be His disciple",
				"pt": "Anyone who does not hate them compared to Him cannot be His disciple"
			},
			"tier": 3,
			"decoys":
			[
				{"en": "Family comes before faith", "pt": "Family comes before faith"},
				{"en": "Only elders must choose", "pt": "Only elders must choose"},
				{
					"en": "He asked for total silence about it",
					"pt": "He asked for total silence about it"
				}
			]
		},
		{
			"question":
			{
				"en": "What did Jesus say about counting the cost of following Him?",
				"pt": "What did Jesus say about counting the cost of following Him?"
			},
			"answer":
			{
				"en": "Whoever does not carry a cross cannot be His disciple",
				"pt": "Whoever does not carry a cross cannot be His disciple"
			},
			"tier": 3,
			"decoys":
			[
				{"en": "Only rulers must count the cost", "pt": "Only rulers must count the cost"},
				{"en": "No cost is involved", "pt": "No cost is involved"},
				{"en": "Only priests must pay a tithe", "pt": "Only priests must pay a tithe"}
			]
		}
	],
	"Death & Resurrection of Jesus":
	[
		{
			"question":
			{
				"en": "Who betrayed Jesus for thirty pieces of silver?",
				"pt": "Quem traiu Jesus por trinta moedas de prata?"
			},
			"answer": {"en": "Judas Iscariot", "pt": "Judas Iscariotes"},
			"tier": 1,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "Thomas", "pt": "Tomás"},
				{"en": "Annas", "pt": "Anás"}
			]
		},
		{
			"question": {"en": "Where was Jesus crucified?", "pt": "Onde Jesus foi crucificado?"},
			"answer": {"en": "Golgotha/Calvary", "pt": "Gólgota/Calvário"},
			"tier": 1,
			"decoys":
			[
				{"en": "Mount of Olives", "pt": "Monte das Oliveiras"},
				{"en": "Mount Zion", "pt": "Monte Sião"},
				{"en": "Bethany hill", "pt": "Colina Betânia"}
			]
		},
		{
			"question":
			{
				"en": "Whose tomb received Jesus' body?",
				"pt": "De quem é o túmulo que recebeu o corpo de Jesus?"
			},
			"answer": {"en": "Joseph of Arimathea's", "pt": "José de Arimateia"},
			"tier": 2,
			"decoys":
			[
				{"en": "Nicodemus'", "pt": "Nicodemos"},
				{"en": "Peter's", "pt": "de Pedro"},
				{"en": "Caiphas'", "pt": "Caifás"}
			]
		},
		{
			"question":
			{
				"en": "Who first saw the risen Jesus near the tomb?",
				"pt": "Quem viu pela primeira vez Jesus ressuscitado perto do túmulo?"
			},
			"answer": {"en": "Mary Magdalene", "pt": "Maria Madalena"},
			"tier": 1,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "John", "pt": "John"},
				{"en": "Mary mother of James", "pt": "Maria mãe de Tiago"}
			]
		},
		{
			"question":
			{
				"en": "On which day after His death did Jesus rise?",
				"pt": "Em que dia após Sua morte Jesus ressuscitou?"
			},
			"answer": {"en": "The third day", "pt": "O terceiro dia"},
			"tier": 1,
			"decoys":
			[
				{"en": "The second day", "pt": "O segundo dia"},
				{"en": "The fourth day", "pt": "O quarto dia"},
				{"en": "The seventh day", "pt": "O sétimo dia"}
			]
		},
		{
			"question":
			{
				"en": "Who denied Jesus three times before the rooster crowed?",
				"pt": "Quem negou Jesus três vezes antes do galo cantar?"
			},
			"answer": {"en": "Peter", "pt": "Peter"},
			"tier": 1,
			"decoys":
			[
				{"en": "Thomas", "pt": "Tomás"},
				{"en": "Andrew", "pt": "André"},
				{"en": "Philip", "pt": "Filipe"}
			]
		},
		{
			"question":
			{
				"en": "Who was compelled to carry Jesus' cross?",
				"pt": "Quem foi obrigado a carregar a cruz de Jesus?"
			},
			"answer": {"en": "Simon of Cyrene", "pt": "Simão de Cirene"},
			"tier": 1,
			"decoys":
			[
				{"en": "Joseph of Arimathea", "pt": "José de Arimatéia"},
				{"en": "Barabbas", "pt": "Barrabás"},
				{"en": "Nicodemus", "pt": "Nicodemos"}
			]
		},
		{
			"question":
			{
				"en": "Which prisoner was released instead of Jesus?",
				"pt": "Qual prisioneiro foi libertado em vez de Jesus?"
			},
			"answer": {"en": "Barabbas", "pt": "Barrabás"},
			"tier": 1,
			"decoys":
			[
				{"en": "Julius", "pt": "Júlio"},
				{"en": "Felix", "pt": "Félix"},
				{"en": "Barnabas", "pt": "Barnabé"}
			]
		},
		{
			"question":
			{
				"en": "What inscription was placed above Jesus on the cross?",
				"pt": "Que inscrição foi colocada acima de Jesus na cruz?"
			},
			"answer": {"en": "King of the Jews", "pt": "Rei dos Judeus"},
			"tier": 2,
			"decoys":
			[
				{"en": "Blasphemer", "pt": "Blasfemador"},
				{"en": "Friend of sinners", "pt": "Amigo dos pecadores"},
				{"en": "King of Galilee", "pt": "Rei da Galileia"}
			]
		},
		{
			"question":
			{
				"en": "What happened to the temple veil when Jesus died?",
				"pt": "O que aconteceu com o véu do templo quando Jesus morreu?"
			},
			"answer":
			{
				"en": "It was torn in two from top to bottom",
				"pt": "Foi rasgado em dois de cima a baixo"
			},
			"tier": 2,
			"decoys":
			[
				{"en": "It was set on fire", "pt": "Foi incendiado"},
				{"en": "It was stolen", "pt": "Foi roubado"},
				{"en": "It turned scarlet", "pt": "Ficou escarlate"}
			]
		},
		{
			"question":
			{
				"en": "How long did darkness cover the land during the crucifixion?",
				"pt": "Por quanto tempo a escuridão cobriu a terra durante a crucificação?"
			},
			"answer": {"en": "About three hours", "pt": "Cerca de três horas"},
			"tier": 2,
			"decoys":
			[
				{"en": "Half an hour", "pt": "Meia hora"},
				{"en": "Until midnight", "pt": "Até meia-noite"},
				{"en": "Six hours straight", "pt": "Seis horas seguidas"}
			]
		},
		{
			"question":
			{
				"en": "Who brought a mixture of myrrh and aloes to help bury Jesus?",
				"pt": "Quem trouxe uma mistura de mirra e aloés para ajudar a enterrar Jesus?"
			},
			"answer": {"en": "Nicodemus", "pt": "Nicodemos"},
			"tier": 2,
			"decoys":
			[
				{"en": "Gamaliel", "pt": "Gamaliel"},
				{"en": "Joseph Barsabbas", "pt": "José Barsabás"},
				{"en": "Simon the Tanner", "pt": "Simão, o Curtidor"}
			]
		},
		{
			"question":
			{
				"en": "What did soldiers cast lots for at the cross?",
				"pt": "O que os soldados lançaram sortes na cruz?"
			},
			"answer": {"en": "Jesus' seamless garment", "pt": "A vestimenta perfeita de Jesus"},
			"tier": 2,
			"decoys":
			[
				{"en": "The crown of thorns", "pt": "A coroa de espinhos"},
				{"en": "Pilate's sign", "pt": "O sinal de Pilatos"},
				{"en": "The jar of vinegar", "pt": "O pote de vinagre"}
			]
		},
		{
			"question":
			{
				"en": "Which disciple would not believe until he saw Jesus' wounds?",
				"pt": "Qual discípulo não acreditaria até ver as feridas de Jesus?"
			},
			"answer": {"en": "Thomas", "pt": "Tomás"},
			"tier": 1,
			"decoys":
			[
				{"en": "John", "pt": "John"},
				{"en": "Andrew", "pt": "André"},
				{"en": "Matthew", "pt": "Mateus"}
			]
		},
		{
			"question":
			{
				"en": "Who told the women at the tomb, 'He is not here; he is risen'?",
				"pt": "Que disse às mulheres no túmulo: 'Ele não está aqui; ele ressuscitou?"
			},
			"answer": {"en": "An angel", "pt": "Um anjo"},
			"tier": 1,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "Joseph of Arimathea", "pt": "José de Arimatéia"},
				{"en": "A soldier", "pt": "Um soldado"}
			]
		},
		{
			"question":
			{
				"en": "On what road did two disciples walk when the risen Jesus joined them?",
				"pt":
				"Por que caminho caminhavam dois discípulos quando Jesus ressuscitado se juntou a eles?"
			},
			"answer": {"en": "The road to Emmaus", "pt": "O caminho para Emaús"},
			"tier": 2,
			"decoys":
			[
				{"en": "The road to Jericho", "pt": "A estrada para Jericó"},
				{"en": "The road to Damascus", "pt": "A estrada para Damasco"},
				{"en": "The road to Bethany", "pt": "O caminho para Betânia"}
			]
		},
		{
			"question":
			{
				"en": "Which disciple outran Peter to the empty tomb?",
				"pt": "Qual discípulo ultrapassou Pedro até o túmulo vazio?"
			},
			"answer": {"en": "John", "pt": "John"},
			"tier": 2,
			"decoys":
			[
				{"en": "James", "pt": "James"},
				{"en": "Andrew", "pt": "André"},
				{"en": "Philip", "pt": "Filipe"}
			]
		},
		{
			"question":
			{
				"en": "From where did Jesus ascend into heaven?",
				"pt": "De onde Jesus ascendeu ao céu?"
			},
			"answer":
			{
				"en": "The Mount of Olives near Bethany",
				"pt": "O Monte das Oliveiras perto de Betânia"
			},
			"tier": 2,
			"decoys":
			[
				{"en": "Mount Sinai", "pt": "Monte Sinai"},
				{"en": "Mount Carmel", "pt": "Monte Carmelo"},
				{"en": "Mount Hermon", "pt": "Monte Hermom"}
			]
		},
		{
			"question":
			{
				"en": "On what day of the week was the resurrection discovered?",
				"pt": "Em que dia da semana foi descoberta a ressurreição?"
			},
			"answer":
			{
				"en": "The first day of the week (Sunday)",
				"pt": "O primeiro dia da semana (domingo)"
			},
			"tier": 1,
			"decoys":
			[
				{"en": "The Sabbath (Saturday)", "pt": "O sábado (sábado)"},
				{"en": "The fourth day", "pt": "O quarto dia"},
				{"en": "A feast day unknown", "pt": "Um dia de festa desconhecido"}
			]
		},
		{
			"question":
			{
				"en": "Who requested a guard at the tomb to prevent tampering?",
				"pt": "Quem solicitou um guarda no túmulo para evitar adulterações?"
			},
			"answer":
			{"en": "The chief priests and Pharisees", "pt": "Os principais sacerdotes e fariseus"},
			"tier": 3,
			"decoys":
			[
				{"en": "The women disciples", "pt": "As mulheres discípulas"},
				{"en": "The Roman centurion", "pt": "O centurião romano"},
				{"en": "Herod Antipas", "pt": "Herodes Antipas"}
			]
		},
		{
			"question":
			{
				"en": "Which women brought spices to the tomb at dawn?",
				"pt": "Which women brought spices to the tomb at dawn?"
			},
			"answer":
			{
				"en": "Mary Magdalene, Mary the mother of James, and Salome",
				"pt": "Mary Magdalene, Mary the mother of James, and Salome"
			},
			"tier": 2,
			"decoys":
			[
				{"en": "Mary and Martha", "pt": "Mary and Martha"},
				{"en": "Priscilla and Phoebe", "pt": "Priscilla and Phoebe"},
				{"en": "Elizabeth and Anna", "pt": "Elizabeth and Anna"}
			]
		},
		{
			"question":
			{
				"en": "Who bribed the guards to say the disciples stole Jesus' body?",
				"pt": "Who bribed the guards to say the disciples stole Jesus' body?"
			},
			"answer": {"en": "The chief priests", "pt": "The chief priests"},
			"tier": 3,
			"decoys":
			[
				{"en": "Herod", "pt": "Herod"},
				{"en": "Pilate", "pt": "Pilate"},
				{"en": "Joseph of Arimathea", "pt": "Joseph of Arimathea"}
			]
		},
		{
			"question":
			{
				"en": "What was bought with the thirty pieces of silver from Judas?",
				"pt": "What was bought with the thirty pieces of silver from Judas?"
			},
			"answer":
			{
				"en": "The potter's field (Field of Blood)",
				"pt": "The potter's field (Field of Blood)"
			},
			"tier": 3,
			"decoys":
			[
				{"en": "A new tomb", "pt": "A new tomb"},
				{"en": "A palace courtyard", "pt": "A palace courtyard"},
				{"en": "A vineyard", "pt": "A vineyard"}
			]
		},
		{
			"question":
			{
				"en": "Who washed his hands saying, 'I am innocent of this man's blood'?",
				"pt": "Who washed his hands saying, 'I am innocent of this man's blood'?"
			},
			"answer": {"en": "Pilate", "pt": "Pilate"},
			"tier": 3,
			"decoys":
			[
				{"en": "Herod", "pt": "Herod"},
				{"en": "Caiaphas", "pt": "Caiaphas"},
				{"en": "Nicodemus", "pt": "Nicodemus"}
			]
		},
		{
			"question":
			{
				"en": "Why did soldiers not break Jesus' legs?",
				"pt": "Why did soldiers not break Jesus' legs?"
			},
			"answer": {"en": "He was already dead", "pt": "He was already dead"},
			"tier": 3,
			"decoys":
			[
				{"en": "They forgot the order", "pt": "They forgot the order"},
				{"en": "They ran out of time", "pt": "They ran out of time"},
				{"en": "They feared the crowd", "pt": "They feared the crowd"}
			]
		},
		{
			"question":
			{
				"en": "In what languages was the inscription on the cross written?",
				"pt": "In what languages was the inscription on the cross written?"
			},
			"answer": {"en": "Hebrew, Latin, and Greek", "pt": "Hebrew, Latin, and Greek"},
			"tier": 3,
			"decoys":
			[
				{"en": "Hebrew only", "pt": "Hebrew only"},
				{"en": "Latin only", "pt": "Latin only"},
				{"en": "Greek and Aramaic", "pt": "Greek and Aramaic"}
			]
		},
		{
			"question":
			{
				"en": "What did a soldier pierce Jesus' side with?",
				"pt": "What did a soldier pierce Jesus' side with?"
			},
			"answer": {"en": "A spear", "pt": "A spear"},
			"tier": 3,
			"decoys":
			[
				{"en": "A sword", "pt": "A sword"},
				{"en": "A staff", "pt": "A staff"},
				{"en": "A lance of bronze", "pt": "A lance of bronze"}
			]
		},
		{
			"question":
			{
				"en": "Which women sat opposite the tomb to see where He was laid?",
				"pt": "Which women sat opposite the tomb to see where He was laid?"
			},
			"answer":
			{"en": "Mary Magdalene and the other Mary", "pt": "Mary Magdalene and the other Mary"},
			"tier": 3,
			"decoys":
			[
				{"en": "Mary and Martha", "pt": "Mary and Martha"},
				{"en": "Salome and Joanna", "pt": "Salome and Joanna"},
				{"en": "Mary of Clopas and Anna", "pt": "Mary of Clopas and Anna"}
			]
		},
		{
			"question":
			{
				"en": "Where was the tomb located in relation to the crucifixion site?",
				"pt": "Where was the tomb located in relation to the crucifixion site?"
			},
			"answer":
			{
				"en": "In a garden near the place of crucifixion",
				"pt": "In a garden near the place of crucifixion"
			},
			"tier": 3,
			"decoys":
			[
				{"en": "Inside the city walls", "pt": "Inside the city walls"},
				{"en": "On the Mount of Olives", "pt": "On the Mount of Olives"},
				{"en": "Beyond Bethany", "pt": "Beyond Bethany"}
			]
		},
		{
			"question":
			{
				"en": "Where was Jesus arrested before His trial?",
				"pt": "Where was Jesus arrested before His trial?"
			},
			"answer": {"en": "In the Garden of Gethsemane", "pt": "In the Garden of Gethsemane"},
			"tier": 3,
			"decoys":
			[
				{"en": "In the temple courts", "pt": "In the temple courts"},
				{"en": "At Herod's palace", "pt": "At Herod's palace"},
				{"en": "In Nazareth", "pt": "In Nazareth"}
			]
		}
	],
	"Disciples & Apostles":
	[
		{
			"question":
			{
				"en": "Which brothers were fishermen called by Jesus?",
				"pt": "Quais irmãos foram pescadores chamados por Jesus?"
			},
			"answer": {"en": "Peter and Andrew", "pt": "Pedro e André"},
			"tier": 1,
			"decoys":
			[
				{"en": "James and John", "pt": "Tiago e João"},
				{"en": "Philip and Nathaniel", "pt": "Filipe e Natanael"},
				{"en": "Thomas and Matthew", "pt": "Tomé e Mateus"}
			]
		},
		{
			"question":
			{
				"en": "Which disciple was a tax collector?",
				"pt": "Qual discípulo era cobrador de impostos?"
			},
			"answer": {"en": "Matthew", "pt": "Mateus"},
			"tier": 1,
			"decoys":
			[
				{"en": "Judas Iscariot", "pt": "Judas Iscariotes"},
				{"en": "Simon the Zealot", "pt": "Simão, o Zelote"},
				{"en": "Philip", "pt": "Filipe"}
			]
		},
		{
			"question":
			{
				"en": "Which disciple is known for doubting until he saw Jesus?",
				"pt": "Qual discípulo é conhecido por duvidar até ver Jesus?"
			},
			"answer": {"en": "Thomas", "pt": "Tomás"},
			"tier": 1,
			"decoys":
			[
				{"en": "Philip", "pt": "Filipe"},
				{"en": "Bartholomew", "pt": "Bartolomeu"},
				{"en": "James the Less", "pt": "Tiago, o Menor"}
			]
		},
		{
			"question":
			{
				"en": "Who was chosen to replace Judas Iscariot?",
				"pt": "Quem foi escolhido para substituir Judas Iscariotes?"
			},
			"answer": {"en": "Matthias", "pt": "Matias"},
			"tier": 2,
			"decoys":
			[
				{"en": "Barsabbas", "pt": "Barrabás"},
				{"en": "Barnabas", "pt": "Barnabé"},
				{"en": "Titus", "pt": "Tito"}
			]
		},
		{
			"question":
			{
				"en": "Who is called the apostle to the Gentiles?",
				"pt": "Quem é chamado de apóstolo dos gentios?"
			},
			"answer": {"en": "Paul", "pt": "Paulo"},
			"tier": 1,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "Barnabas", "pt": "Barnabé"},
				{"en": "Silas", "pt": "Silas"}
			]
		},
		{
			"question":
			{
				"en": "Which two disciples were called the 'Sons of Thunder'?",
				"pt": "Quais dois discípulos foram chamados de 'Filhos do Trovão'?"
			},
			"answer": {"en": "James and John", "pt": "Tiago e João"},
			"tier": 2,
			"decoys":
			[
				{"en": "Peter and Andrew", "pt": "Pedro e André"},
				{"en": "Philip and Bartholomew", "pt": "Filipe e Bartolomeu"},
				{"en": "James and Jude", "pt": "Tiago e Judas"}
			]
		},
		{
			"question":
			{
				"en": "Which disciple is often called the beloved disciple?",
				"pt": "Qual discípulo é frequentemente chamado de discípulo amado?"
			},
			"answer": {"en": "John", "pt": "John"},
			"tier": 1,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "James", "pt": "James"},
				{"en": "Thomas", "pt": "Tomás"}
			]
		},
		{
			"question":
			{
				"en": "Who brought his brother Simon to meet Jesus?",
				"pt": "Quem trouxe seu irmão Simão para conhecer Jesus?"
			},
			"answer": {"en": "Andrew", "pt": "André"},
			"tier": 1,
			"decoys":
			[
				{"en": "Philip", "pt": "Filipe"},
				{"en": "John", "pt": "John"},
				{"en": "Matthew", "pt": "Mateus"}
			]
		},
		{
			"question":
			{
				"en": "Which disciple kept the money bag for the group?",
				"pt": "Qual discípulo guardou a bolsa de dinheiro para o grupo?"
			},
			"answer": {"en": "Judas Iscariot", "pt": "Judas Iscariotes"},
			"tier": 2,
			"decoys":
			[
				{"en": "Thomas", "pt": "Tomás"},
				{"en": "Bartholomew", "pt": "Bartolomeu"},
				{"en": "James the Less", "pt": "Tiago, o Menor"}
			]
		},
		{
			"question":
			{
				"en": "Which disciple was also known as Nathanael?",
				"pt": "Qual discípulo também era conhecido como Natanael?"
			},
			"answer": {"en": "Bartholomew", "pt": "Bartolomeu"},
			"tier": 2,
			"decoys":
			[
				{"en": "Thaddeus", "pt": "Tadeu"},
				{"en": "James the Less", "pt": "Tiago, o Menor"},
				{"en": "Simon the Zealot", "pt": "Simão, o Zelote"}
			]
		},
		{
			"question":
			{
				"en": "Which disciple was called the Zealot?",
				"pt": "Qual discípulo foi chamado de Zelote?"
			},
			"answer": {"en": "Simon", "pt": "Simão"},
			"tier": 2,
			"decoys":
			[
				{"en": "Judas Iscariot", "pt": "Judas Iscariotes"},
				{"en": "Andrew", "pt": "André"},
				{"en": "Philip", "pt": "Filipe"}
			]
		},
		{
			"question":
			{
				"en": "Who asked Jesus, 'Show us the Father, and it is enough for us'?",
				"pt": "Quem perguntou a Jesus: 'Mostra-nos o Pai, e isso nos basta'?"
			},
			"answer": {"en": "Philip", "pt": "Filipe"},
			"tier": 2,
			"decoys":
			[
				{"en": "Thomas", "pt": "Tomás"},
				{"en": "Peter", "pt": "Peter"},
				{"en": "Jude", "pt": "Judas"}
			]
		},
		{
			"question":
			{
				"en": "Who declared, 'You are the Christ, the Son of the living God'?",
				"pt": "Quem declarou: 'Tu és o Cristo, o Filho do Deus vivo'?"
			},
			"answer": {"en": "Peter", "pt": "Peter"},
			"tier": 1,
			"decoys":
			[
				{"en": "Thomas", "pt": "Tomás"},
				{"en": "Philip", "pt": "Filipe"},
				{"en": "Bartholomew", "pt": "Bartolomeu"}
			]
		},
		{
			"question":
			{
				"en": "Which disciple briefly walked on water toward Jesus?",
				"pt": "Qual discípulo caminhou brevemente sobre as águas em direção a Jesus?"
			},
			"answer": {"en": "Peter", "pt": "Peter"},
			"tier": 1,
			"decoys":
			[
				{"en": "John", "pt": "John"},
				{"en": "Andrew", "pt": "André"},
				{"en": "James", "pt": "James"}
			]
		},
		{
			"question":
			{
				"en": "Who was the first apostle martyred in Acts 12?",
				"pt": "Quem foi o primeiro apóstolo martirizado em Atos 12?"
			},
			"answer": {"en": "James the son of Zebedee", "pt": "Tiago, filho de Zebedeu"},
			"tier": 3,
			"decoys":
			[
				{"en": "John", "pt": "John"},
				{"en": "Peter", "pt": "Peter"},
				{"en": "Matthias", "pt": "Matias"}
			]
		},
		{
			"question":
			{
				"en": "Which apostle wrote the Book of Revelation?",
				"pt": "Qual apóstolo escreveu o livro do Apocalipse?"
			},
			"answer": {"en": "John", "pt": "John"},
			"tier": 2,
			"decoys":
			[
				{"en": "Matthew", "pt": "Mateus"},
				{"en": "Paul", "pt": "Paulo"},
				{"en": "Luke", "pt": "Lucas"}
			]
		},
		{
			"question":
			{
				"en": "Which disciple was called Didymus, meaning the Twin?",
				"pt": "Qual discípulo se chamava Dídimo, que significa Gêmeo?"
			},
			"answer": {"en": "Thomas", "pt": "Tomás"},
			"tier": 2,
			"decoys":
			[
				{"en": "Bartholomew", "pt": "Bartolomeu"},
				{"en": "James the Less", "pt": "Tiago, o Menor"},
				{"en": "Jude", "pt": "Judas"}
			]
		},
		{
			"question":
			{
				"en": "Which disciple was from Cana in Galilee?",
				"pt": "Qual discípulo era de Caná da Galiléia?"
			},
			"answer": {"en": "Nathanael", "pt": "Natanael"},
			"tier": 3,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "Jude", "pt": "Judas"},
				{"en": "Paul", "pt": "Paulo"}
			]
		},
		{
			"question":
			{
				"en": "Which disciple objected when Jesus tried to wash his feet?",
				"pt": "Qual discípulo objetou quando Jesus tentou lavar-lhe os pés?"
			},
			"answer": {"en": "Peter", "pt": "Peter"},
			"tier": 2,
			"decoys":
			[
				# Helper para pegar o nome da categoria no idioma certo
				{"en": "John", "pt": "John"},
				{"en": "Andrew", "pt": "André"},
				{"en": "James", "pt": "James"}
			]
		},
		{
			"question":
			{
				"en":
				"Who was nicknamed the 'son of encouragement' and sold a field for the church?",
				"pt":
				"Quem foi apelidado de ‘filho do encorajamento’ e vendeu um campo para a igreja?"
			},
			"answer": {"en": "Barnabas", "pt": "Barnabé"},
			"tier": 2,
			"decoys":
			[
				{"en": "Silas", "pt": "Silas"},
				{"en": "Luke", "pt": "Lucas"},
				{"en": "Apollos", "pt": "Apolo"}
			]
		},
		{
			"question":
			{
				"en": "Which disciple was also called Levi?",
				"pt": "Which disciple was also called Levi?"
			},
			"answer": {"en": "Matthew", "pt": "Matthew"},
			"tier": 1,
			"decoys":
			[
				{"en": "James", "pt": "James"},
				{"en": "Andrew", "pt": "Andrew"},
				{"en": "Philip", "pt": "Philip"}
			]
		},
		{
			"question":
			{
				"en": "Which three disciples saw the Transfiguration?",
				"pt": "Which three disciples saw the Transfiguration?"
			},
			"answer": {"en": "Peter, James, and John", "pt": "Peter, James, and John"},
			"tier": 1,
			"decoys":
			[
				{"en": "Peter, Andrew, and Philip", "pt": "Peter, Andrew, and Philip"},
				{"en": "James, John, and Thomas", "pt": "James, John, and Thomas"},
				{"en": "Peter, Thomas, and Matthew", "pt": "Peter, Thomas, and Matthew"}
			]
		},
		{
			"question":
			{
				"en": "Whose shadow was said to heal the sick in Jerusalem?",
				"pt": "Whose shadow was said to heal the sick in Jerusalem?"
			},
			"answer": {"en": "Peter", "pt": "Peter"},
			"tier": 3,
			"decoys":
			[
				{"en": "John", "pt": "John"},
				{"en": "Paul", "pt": "Paul"},
				{"en": "Barnabas", "pt": "Barnabas"}
			]
		},
		{
			"question":
			{
				"en": "Who was also called Barsabbas (Justus) but not chosen to replace Judas?",
				"pt": "Who was also called Barsabbas (Justus) but not chosen to replace Judas?"
			},
			"answer": {"en": "Joseph called Barsabbas", "pt": "Joseph called Barsabbas"},
			"tier": 3,
			"decoys":
			[
				{"en": "Judas son of James", "pt": "Judas son of James"},
				{"en": "Matthias", "pt": "Matthias"},
				{"en": "Titius Justus", "pt": "Titius Justus"}
			]
		},
		{
			"question":
			{
				"en": "Who saw a sheet of unclean animals in a rooftop vision at Joppa?",
				"pt": "Who saw a sheet of unclean animals in a rooftop vision at Joppa?"
			},
			"answer": {"en": "Peter", "pt": "Peter"},
			"tier": 3,
			"decoys":
			[
				{"en": "John", "pt": "John"},
				{"en": "Philip", "pt": "Philip"},
				{"en": "Stephen", "pt": "Stephen"}
			]
		},
		{
			"question":
			{
				"en": "Who was called a pillar along with Peter and John?",
				"pt": "Who was called a pillar along with Peter and John?"
			},
			"answer": {"en": "James, the brother of Jesus", "pt": "James, the brother of Jesus"},
			"tier": 3,
			"decoys":
			[
				{"en": "Thomas", "pt": "Thomas"},
				{"en": "Bartholomew", "pt": "Bartholomew"},
				{"en": "Jude", "pt": "Jude"}
			]
		},
		{
			"question":
			{
				"en": "Who was called Hermes because he was the chief speaker at Lystra?",
				"pt": "Who was called Hermes because he was the chief speaker at Lystra?"
			},
			"answer": {"en": "Paul", "pt": "Paul"},
			"tier": 3,
			"decoys":
			[
				{"en": "Barnabas", "pt": "Barnabas"},
				{"en": "Silas", "pt": "Silas"},
				{"en": "Timothy", "pt": "Timothy"}
			]
		},
		{
			"question":
			{
				"en": "Who was called Zeus at Lystra when a lame man was healed?",
				"pt": "Who was called Zeus at Lystra when a lame man was healed?"
			},
			"answer": {"en": "Barnabas", "pt": "Barnabas"},
			"tier": 3,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "James", "pt": "James"},
				{"en": "Apollos", "pt": "Apollos"}
			]
		},
		{
			"question":
			{
				"en": "Whose house did Peter stay in Joppa for many days?",
				"pt": "Whose house did Peter stay in Joppa for many days?"
			},
			"answer": {"en": "Simon the tanner", "pt": "Simon the tanner"},
			"tier": 3,
			"decoys":
			[
				{"en": "Cornelius", "pt": "Cornelius"},
				{"en": "Philip", "pt": "Philip"},
				{"en": "Agabus", "pt": "Agabus"}
			]
		},
		{
			"question":
			{
				"en": "Who took Mark to Cyprus after a sharp disagreement with Paul?",
				"pt": "Who took Mark to Cyprus after a sharp disagreement with Paul?"
			},
			"answer": {"en": "Barnabas", "pt": "Barnabas"},
			"tier": 3,
			"decoys":
			[
				{"en": "Silas", "pt": "Silas"},
				{"en": "Luke", "pt": "Luke"},
				{"en": "Titus", "pt": "Titus"}
			]
		}
	],
	"Early Church (Acts)":
	[
		{
			"question":
			{
				"en": "What feast day did the Holy Spirit fall in Acts 2?",
				"pt": "Em que dia de festa o Espírito Santo desceu em Atos 2?"
			},
			"answer": {"en": "Pentecost", "pt": "Pentecostes"},
			"tier": 1,
			"decoys":
			[
				{"en": "Passover", "pt": "Páscoa"},
				{"en": "Tabernacles", "pt": "Tabernáculos"},
				{"en": "Firstfruits", "pt": "Primícias"}
			]
		},
		{
			"question":
			{
				"en": "Who was the first Christian martyr?",
				"pt": "Quem foi o primeiro mártir cristão?"
			},
			"answer": {"en": "Stephen", "pt": "Estêvão"},
			"tier": 1,
			"decoys":
			[
				{"en": "James", "pt": "James"},
				{"en": "Peter", "pt": "Peter"},
				{"en": "Philip", "pt": "Filipe"}
			]
		},
		{
			"question":
			{
				"en": "Who met Jesus on the road to Damascus?",
				"pt": "Quem conheceu Jesus no caminho para Damasco?"
			},
			"answer": {"en": "Saul/Paul", "pt": "Saulo/Paulo"},
			"tier": 1,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "Ananias", "pt": "Ananias"},
				{"en": "Barnabas", "pt": "Barnabé"}
			]
		},
		{
			"question":
			{
				"en": "Who was the Roman centurion Peter visited after a vision?",
				"pt": "Quem foi o centurião romano que Pedro visitou depois de uma visão?"
			},
			"answer": {"en": "Cornelius", "pt": "Cornélio"},
			"tier": 2,
			"decoys":
			[
				{"en": "Julius", "pt": "Júlio"},
				{"en": "Festus", "pt": "Festo"},
				{"en": "Agrippa", "pt": "Agripa"}
			]
		},
		{
			"question":
			{
				"en": "Who healed the lame man at the temple gate Beautiful?",
				"pt": "Quem curou o coxo na porta do templo Belo?"
			},
			"answer": {"en": "Peter", "pt": "Peter"},
			"tier": 1,
			"decoys":
			[
				{"en": "John", "pt": "John"},
				{"en": "Philip", "pt": "Filipe"},
				{"en": "Paul", "pt": "Paulo"}
			]
		},
		{
			"question":
			{
				"en": "Where were followers of Jesus first called Christians?",
				"pt": "Onde os seguidores de Jesus foram chamados de cristãos pela primeira vez?"
			},
			"answer": {"en": "Antioch", "pt": "Antioquia"},
			"tier": 1,
			"decoys":
			[
				{"en": "Jerusalem", "pt": "Jerusalém"},
				{"en": "Damascus", "pt": "Damasco"},
				{"en": "Corinth", "pt": "Corinto"}
			]
		},
		{
			"question":
			{
				"en": "Which couple lied about a land offering and fell dead?",
				"pt": "Qual casal mentiu sobre uma oferta de terras e caiu morto?"
			},
			"answer": {"en": "Ananias and Sapphira", "pt": "Ananias e Safira"},
			"tier": 2,
			"decoys":
			[
				{"en": "Aquila and Priscilla", "pt": "Áquila e Priscila"},
				{"en": "Lydia and Euodia", "pt": "Lídia e Evódia"},
				{"en": "Rhoda and Dorcas", "pt": "Rode e Dorcas"}
			]
		},
		{
			"question":
			{
				"en": "Which of the seven chosen servants preached powerfully and was martyred?",
				"pt": "Qual dos sete servos escolhidos pregou poderosamente e foi martirizado?"
			},
			"answer": {"en": "Stephen", "pt": "Estêvão"},
			"tier": 2,
			"decoys":
			[
				{"en": "Philip", "pt": "Filipe"},
				{"en": "Barnabas", "pt": "Barnabé"},
				{"en": "Nicanor", "pt": "Nicanor"}
			]
		},
		{
			"question":
			{
				"en": "Who baptized the Ethiopian eunuch on the desert road?",
				"pt": "Quem batizou o eunuco etíope na estrada do deserto?"
			},
			"answer": {"en": "Philip the evangelist", "pt": "Filipe, o evangelista"},
			"tier": 2,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "Cornelius", "pt": "Cornélio"},
				{"en": "Silas", "pt": "Silas"}
			]
		},
		{
			"question":
			{
				"en": "Who restored Saul's sight after a vision?",
				"pt": "Quem restaurou a visão de Saulo após uma visão?"
			},
			"answer": {"en": "Ananias of Damascus", "pt": "Ananias de Damasco"},
			"tier": 2,
			"decoys":
			[
				{"en": "Barnabas", "pt": "Barnabé"},
				{"en": "Gamaliel", "pt": "Gamaliel"},
				{"en": "Annas", "pt": "Anás"}
			]
		},
		{
			"question":
			{
				"en": "What sorcerer tried to buy the gift of God with money?",
				"pt": "Que feiticeiro tentou comprar o dom de Deus com dinheiro?"
			},
			"answer": {"en": "Simon the Magician", "pt": "Simão, o Mágico"},
			"tier": 2,
			"decoys":
			[
				{"en": "Bar-Jesus", "pt": "Bar-Jesus"},
				{"en": "Demas", "pt": "Demas"},
				{"en": "Alexander", "pt": "Alexandre"}
			]
		},
		{
			"question":
			{
				"en": "Which council decided Gentile believers did not need circumcision?",
				"pt": "Qual conselho decidiu que os crentes gentios não precisavam da circuncisão?"
			},
			"answer": {"en": "The Jerusalem Council", "pt": "O Concílio de Jerusalém"},
			"tier": 3,
			"decoys":
			[
				{"en": "The Council of Nicaea", "pt": "O Concílio de Nicéia"},
				{"en": "A Sanhedrin trial", "pt": "Um julgamento do Sinédrio"},
				{"en": "The council in Rome", "pt": "O conselho em Roma"}
			]
		},
		{
			"question":
			{
				"en": "Who opened her home after believing by the river in Philippi?",
				"pt": "Quem abriu sua casa depois de crer à beira do rio em Filipos?"
			},
			"answer": {"en": "Lydia", "pt": "Lídia"},
			"tier": 2,
			"decoys":
			[
				{"en": "Tabitha", "pt": "Tabita"},
				{"en": "Sapphira", "pt": "Safira"},
				{"en": "Martha", "pt": "Marta"}
			]
		},
		{
			"question":
			{
				"en": "Who fell asleep during Paul's sermon and fell from a window?",
				"pt": "Quem adormeceu durante o sermão de Paulo e caiu de uma janela?"
			},
			"answer": {"en": "Eutychus", "pt": "Êutico"},
			"tier": 3,
			"decoys":
			[
				{"en": "John Mark", "pt": "João Marcos"},
				{"en": "Timothy", "pt": "Timóteo"},
				{"en": "Elymas", "pt": "Elimas"}
			]
		},
		{
			"question":
			{
				"en": "Who sold a field and laid the money at the apostles' feet?",
				"pt": "Quem vendeu um campo e depositou o dinheiro aos pés dos apóstolos?"
			},
			"answer": {"en": "Barnabas", "pt": "Barnabé"},
			"tier": 2,
			"decoys":
			[
				{"en": "Simon Magus", "pt": "Simão Mago"},
				{"en": "Cornelius", "pt": "Cornélio"},
				{"en": "Sergius Paulus", "pt": "Sérgio Paulo"}
			]
		},
		{
			"question":
			{
				"en": "Who sang hymns with Paul at midnight in a Philippian jail?",
				"pt": "Quem cantou hinos com Paulo à meia-noite numa prisão de Filipos?"
			},
			"answer": {"en": "Silas", "pt": "Silas"},
			"tier": 1,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "John", "pt": "John"},
				{"en": "Barnabas", "pt": "Barnabé"}
			]
		},
		{
			"question":
			{
				"en": "Who explained the way of God more accurately to Apollos?",
				"pt": "Quem explicou o caminho de Deus com mais precisão a Apolo?"
			},
			"answer": {"en": "Priscilla and Aquila", "pt": "Priscila e Áquila"},
			"tier": 2,
			"decoys":
			[
				{"en": "Ananias and Sapphira", "pt": "Ananias e Safira"},
				{"en": "Mary and Martha", "pt": "Maria e Marta"},
				{"en": "Lois and Eunice", "pt": "Luísa e Eunice"}
			]
		},
		{
			"question":
			{
				"en": "Which apostle was killed by Herod Agrippa I with the sword?",
				"pt": "Qual apóstolo foi morto por Herodes Agripa I com a espada?"
			},
			"answer": {"en": "James the son of Zebedee", "pt": "Tiago, filho de Zebedeu"},
			"tier": 3,
			"decoys":
			[
				{"en": "Stephen", "pt": "Estêvão"},
				{"en": "Philip", "pt": "Filipe"},
				{"en": "Matthias", "pt": "Matias"}
			]
		},
		{
			"question":
			{
				"en": "After Peter was freed from prison, whose house did he visit?",
				"pt": "Depois que Pedro foi libertado da prisão, a casa de quem ele visitou?"
			},
			"answer": {"en": "Mary the mother of John Mark", "pt": "Maria, mãe de João Marcos"},
			"tier": 3,
			"decoys":
			[
				{"en": "Lydia's house", "pt": "Casa de Lídia"},
				{"en": "Aquila's home", "pt": "A casa de Áquila"},
				{"en": "Cornelius' house", "pt": "casa de Cornélio"}
			]
		},
		{
			"question":
			{
				"en": "What practices did the early believers devote themselves to in Acts 2:42?",
				"pt": "A quais práticas os primeiros crentes se dedicaram em Atos 2:42?"
			},
			"answer":
			{
				"en": "Apostles' teaching, fellowship, breaking bread, and prayer",
				"pt": "Ensino dos apóstolos, comunhão, fração do pão e oração"
			},
			"tier": 2,
			"decoys":
			[
				{"en": "Building a new temple", "pt": "Construindo um novo templo"},
				{"en": "Learning Greek philosophy", "pt": "Aprendendo filosofia grega"},
				{"en": "Training soldiers for revolt", "pt": "Treinando soldados para a revolta"}
			]
		},
		{
			"question":
			{
				"en": "Who preached the sermon at Pentecost?",
				"pt": "Who preached the sermon at Pentecost?"
			},
			"answer": {"en": "Peter", "pt": "Peter"},
			"tier": 1,
			"decoys":
			[
				{"en": "John", "pt": "John"},
				{"en": "Stephen", "pt": "Stephen"},
				{"en": "Philip", "pt": "Philip"}
			]
		},
		{
			"question":
			{
				"en": "About how many were added to the believers on Pentecost?",
				"pt": "About how many were added to the believers on Pentecost?"
			},
			"answer": {"en": "About three thousand", "pt": "About three thousand"},
			"tier": 1,
			"decoys":
			[
				{"en": "About five hundred", "pt": "About five hundred"},
				{"en": "About seven thousand", "pt": "About seven thousand"},
				{"en": "About twelve hundred", "pt": "About twelve hundred"}
			]
		},
		{
			"question":
			{
				"en": "In which city did the Holy Spirit fall at Pentecost?",
				"pt": "In which city did the Holy Spirit fall at Pentecost?"
			},
			"answer": {"en": "Jerusalem", "pt": "Jerusalem"},
			"tier": 1,
			"decoys":
			[
				{"en": "Antioch", "pt": "Antioch"},
				{"en": "Samaria", "pt": "Samaria"},
				{"en": "Damascus", "pt": "Damascus"}
			]
		},
		{
			"question":
			{
				"en": "Who brought the gospel to Samaria with signs and joy?",
				"pt": "Who brought the gospel to Samaria with signs and joy?"
			},
			"answer": {"en": "Philip", "pt": "Philip"},
			"tier": 1,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "Stephen", "pt": "Stephen"},
				{"en": "Barnabas", "pt": "Barnabas"}
			]
		},
		{
			"question":
			{
				"en": "Who prophesied a coming famine in Acts?",
				"pt": "Who prophesied a coming famine in Acts?"
			},
			"answer": {"en": "Agabus", "pt": "Agabus"},
			"tier": 3,
			"decoys":
			[
				{"en": "Tychicus", "pt": "Tychicus"},
				{"en": "Alexander", "pt": "Alexander"},
				{"en": "Jason", "pt": "Jason"}
			]
		},
		{
			"question":
			{
				"en": "Who was struck blind at Paphos for opposing Paul and Barnabas?",
				"pt": "Who was struck blind at Paphos for opposing Paul and Barnabas?"
			},
			"answer": {"en": "Elymas (Bar-Jesus)", "pt": "Elymas (Bar-Jesus)"},
			"tier": 3,
			"decoys":
			[
				{"en": "Simon Magus", "pt": "Simon Magus"},
				{"en": "Herod Agrippa", "pt": "Herod Agrippa"},
				{"en": "Demetrius", "pt": "Demetrius"}
			]
		},
		{
			"question":
			{
				"en": "Which king was struck by an angel and eaten by worms?",
				"pt": "Which king was struck by an angel and eaten by worms?"
			},
			"answer": {"en": "Herod Agrippa I", "pt": "Herod Agrippa I"},
			"tier": 3,
			"decoys":
			[
				{"en": "Herod Antipas", "pt": "Herod Antipas"},
				{"en": "Herod Archelaus", "pt": "Herod Archelaus"},
				{"en": "Felix", "pt": "Felix"}
			]
		},
		{
			"question":
			{
				"en": "In what city were Paul and Barnabas called Zeus and Hermes?",
				"pt": "In what city were Paul and Barnabas called Zeus and Hermes?"
			},
			"answer": {"en": "Lystra", "pt": "Lystra"},
			"tier": 3,
			"decoys":
			[
				{"en": "Derbe", "pt": "Derbe"},
				{"en": "Iconium", "pt": "Iconium"},
				{"en": "Philippi", "pt": "Philippi"}
			]
		},
		{
			"question":
			{
				"en":
				"At whose house in Joppa did Peter stay long enough for people to gather at the door?",
				"pt":
				"At whose house in Joppa did Peter stay long enough for people to gather at the door?"
			},
			"answer": {"en": "Simon the tanner", "pt": "Simon the tanner"},
			"tier": 3,
			"decoys":
			[
				{"en": "Mary the mother of John Mark", "pt": "Mary the mother of John Mark"},
				{"en": "Cornelius", "pt": "Cornelius"},
				{"en": "Rhoda", "pt": "Rhoda"}
			]
		},
		{
			"question":
			{
				"en": "In which city did many burn magic scrolls worth fifty thousand drachmas?",
				"pt": "In which city did many burn magic scrolls worth fifty thousand drachmas?"
			},
			"answer": {"en": "Ephesus", "pt": "Ephesus"},
			"tier": 3,
			"decoys":
			[
				{"en": "Philippi", "pt": "Philippi"},
				{"en": "Corinth", "pt": "Corinth"},
				{"en": "Caesarea", "pt": "Caesarea"}
			]
		}
	],
	"Journeys of Paul":
	[
		{
			"question":
			{
				"en": "Who traveled with Paul on his first missionary journey?",
				"pt": "Quem viajou com Paulo em sua primeira viagem missionária?"
			},
			"answer": {"en": "Barnabas", "pt": "Barnabé"},
			"tier": 2,
			"decoys":
			[
				{"en": "Silas", "pt": "Silas"},
				{"en": "Luke", "pt": "Lucas"},
				{"en": "Mark", "pt": "Marca"}
			]
		},
		{
			"question":
			{"en": "On which island was Paul shipwrecked?", "pt": "Em que ilha Paulo naufragou?"},
			"answer": {"en": "Malta", "pt": "Malta"},
			"tier": 1,
			"decoys":
			[
				{"en": "Crete", "pt": "Creta"},
				{"en": "Patmos", "pt": "Patmos"},
				{"en": "Cyprus", "pt": "Chipre"}
			]
		},
		{
			"question":
			{
				"en": "What vision led Paul to Macedonia?",
				"pt": "Que visão levou Paulo à Macedônia?"
			},
			"answer":
			{
				"en": "A Macedonian man begging for help",
				"pt": "Um homem macedônio implorando por ajuda"
			},
			"tier": 1,
			"decoys":
			[
				{"en": "An angel with a scroll", "pt": "Um anjo com um pergaminho"},
				{"en": "A man from Judea", "pt": "Um homem da Judéia"},
				{"en": "A dream of a storm", "pt": "Um sonho de uma tempestade"}
			]
		},
		{
			"question":
			{
				"en": "Who was Paul's young coworker he mentored?",
				"pt": "Quem foi o jovem colega de trabalho de Paul que ele orientou?"
			},
			"answer": {"en": "Timothy", "pt": "Timóteo"},
			"tier": 1,
			"decoys":
			[
				{"en": "Titus", "pt": "Tito"},
				{"en": "Mark", "pt": "Marca"},
				{"en": "Silas", "pt": "Silas"}
			]
		},
		{
			"question":
			{
				"en": "Where was Paul imprisoned when he wrote several letters?",
				"pt": "Onde Paulo foi preso quando escreveu várias cartas?"
			},
			"answer": {"en": "Rome", "pt": "Roma"},
			"tier": 1,
			"decoys":
			[
				{"en": "Caesarea", "pt": "Cesaréia"},
				{"en": "Philippi", "pt": "Filipos"},
				{"en": "Ephesus", "pt": "Éfeso"}
			]
		},
		{
			"question":
			{
				"en":
				"In which city did Paul and Silas sing hymns until an earthquake opened the prison?",
				"pt":
				"Em que cidade Paulo e Silas cantaram hinos até que um terremoto abriu a prisão?"
			},
			"answer": {"en": "Philippi", "pt": "Filipos"},
			"tier": 1,
			"decoys":
			[
				{"en": "Corinth", "pt": "Corinto"},
				{"en": "Antioch", "pt": "Antioquia"},
				{"en": "Lystra", "pt": "Listra"}
			]
		},
		{
			"question":
			{
				"en": "Where did Paul address philosophers at the Areopagus?",
				"pt": "Onde Paulo se dirigiu aos filósofos no Areópago?"
			},
			"answer": {"en": "Athens", "pt": "Atenas"},
			"tier": 1,
			"decoys":
			[
				{"en": "Rome", "pt": "Roma"},
				{"en": "Caesarea", "pt": "Cesaréia"},
				{"en": "Iconium", "pt": "Icônio"}
			]
		},
		{
			"question":
			{
				"en": "Where was Paul stoned and left for dead on a journey?",
				"pt": "Onde Paulo foi apedrejado e deixado como morto durante uma viagem?"
			},
			"answer": {"en": "Lystra", "pt": "Listra"},
			"tier": 2,
			"decoys":
			[
				{"en": "Derbe", "pt": "Derbe"},
				{"en": "Pisidian Antioch", "pt": "Antioquia da Pisídia"},
				{"en": "Troas", "pt": "Trôade"}
			]
		},
		{
			"question":
			{
				"en": "Which city erupted in a riot over the goddess Artemis during Paul's stay?",
				"pt":
				"Qual cidade irrompeu num motim por causa da deusa Ártemis durante a estada de Paulo?"
			},
			"answer": {"en": "Ephesus", "pt": "Éfeso"},
			"tier": 2,
			"decoys":
			[
				{"en": "Corinth", "pt": "Corinto"},
				{"en": "Philippi", "pt": "Filipos"},
				{"en": "Thessalonica", "pt": "Tessalônica"}
			]
		},
		{
			"question":
			{
				"en": "Who traveled with Paul after Barnabas took Mark?",
				"pt": "Quem viajou com Paulo depois que Barnabé levou Marcos?"
			},
			"answer": {"en": "Silas", "pt": "Silas"},
			"tier": 1,
			"decoys":
			[
				{"en": "Barnabas", "pt": "Barnabé"},
				{"en": "John Mark", "pt": "João Marcos"},
				{"en": "Luke", "pt": "Lucas"}
			]
		},
		{
			"question":
			{
				"en": "Who was the tentmaking couple Paul stayed with in Corinth?",
				"pt": "Quem era o casal de fazedores de tendas com quem Paulo ficou em Corinto?"
			},
			"answer": {"en": "Priscilla and Aquila", "pt": "Priscila e Áquila"},
			"tier": 2,
			"decoys":
			[
				{"en": "Ananias and Sapphira", "pt": "Ananias e Safira"},
				{"en": "Mary and Martha", "pt": "Maria e Marta"},
				{"en": "Lois and Eunice", "pt": "Luísa e Eunice"}
			]
		},
		{
			"question":
			{
				"en": "Which governor heard Paul's defense along with Drusilla at Caesarea?",
				"pt": "Qual governador ouviu a defesa de Paulo junto com Drusila em Cesaréia?"
			},
			"answer": {"en": "Felix", "pt": "Félix"},
			"tier": 2,
			"decoys":
			[
				{"en": "Festus", "pt": "Festo"},
				{"en": "Agrippa II", "pt": "Agripa II"},
				{"en": "Pilate", "pt": "Pilatos"}
			]
		},
		{
			"question":
			{
				"en": "What centurion from the Imperial Regiment escorted Paul to Rome?",
				"pt": "Que centurião do Regimento Imperial acompanhou Paulo até Roma?"
			},
			"answer": {"en": "Julius", "pt": "Júlio"},
			"tier": 2,
			"decoys":
			[
				{"en": "Cornelius", "pt": "Cornélio"},
				{"en": "Sergius Paulus", "pt": "Sérgio Paulo"},
				{"en": "Claudius Lysias", "pt": "Cláudio Lísias"}
			]
		},
		{
			"question":
			{
				"en": "How many people were aboard the ship that wrecked on Malta?",
				"pt": "Quantas pessoas estavam a bordo do navio que naufragou em Malta?"
			},
			"answer": {"en": "276", "pt": "276"},
			"tier": 3,
			"decoys":
			[{"en": "120", "pt": "120"}, {"en": "70", "pt": "70"}, {"en": "300", "pt": "300"}]
		},
		{
			"question":
			{
				"en": "Who struck Elymas the sorcerer blind on Cyprus?",
				"pt": "Quem cegou Elimas, o feiticeiro, em Chipre?"
			},
			"answer": {"en": "Paul", "pt": "Paulo"},
			"tier": 1,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "Barnabas", "pt": "Barnabé"},
				{"en": "John Mark", "pt": "João Marcos"}
			]
		},
		{
			"question":
			{
				"en": "Which proconsul believed after hearing Paul on Cyprus?",
				"pt": "Qual procônsul acreditou depois de ouvir Paulo sobre Chipre?"
			},
			"answer": {"en": "Sergius Paulus", "pt": "Sérgio Paulo"},
			"tier": 2,
			"decoys":
			[
				{"en": "Gallio", "pt": "Gálio"},
				{"en": "Felix", "pt": "Félix"},
				{"en": "Barnabas", "pt": "Barnabé"}
			]
		},
		{
			"question":
			{
				"en": "What city was known for examining the Scriptures daily after Paul preached?",
				"pt":
				"Que cidade era conhecida por examinar as Escrituras diariamente depois da pregação de Paulo?"
			},
			"answer": {"en": "Berea", "pt": "Beréia"},
			"tier": 1,
			"decoys":
			[
				{"en": "Corinth", "pt": "Corinto"},
				{"en": "Athens", "pt": "Atenas"},
				{"en": "Caesarea", "pt": "Cesaréia"}
			]
		},
		{
			"question":
			{
				"en": "Who joined Paul's team at Troas, signaled by the 'we' sections in Acts?",
				"pt":
				"Quem se juntou à equipe de Paulo em Trôade, sinalizado pelas seções “nós” em Atos?"
			},
			"answer": {"en": "Luke", "pt": "Lucas"},
			"tier": 2,
			"decoys":
			[
				{"en": "Silas", "pt": "Silas"},
				{"en": "Apollos", "pt": "Apolo"},
				{"en": "Titus", "pt": "Tito"}
			]
		},
		{
			"question":
			{
				"en": "Where did Paul give a tearful farewell to the Ephesian elders?",
				"pt": "Onde Paulo se despediu com lágrimas nos anciãos de Éfeso?"
			},
			"answer": {"en": "Miletus", "pt": "Mileto"},
			"tier": 2,
			"decoys":
			[
				{"en": "Troas", "pt": "Trôade"},
				{"en": "Antioch", "pt": "Antioquia"},
				{"en": "Damascus", "pt": "Damasco"}
			]
		},
		{
			"question":
			{
				"en": "At what port did Paul take a vow and cut his hair during a journey?",
				"pt": "Em que porto Paulo fez um voto e cortou o cabelo durante uma viagem?"
			},
			"answer": {"en": "Cenchreae", "pt": "Cencréia"},
			"tier": 3,
			"decoys":
			[
				{"en": "Joppa", "pt": "Jope"},
				{"en": "Caesarea", "pt": "Cesaréia"},
				{"en": "Sidon", "pt": "Sídon"}
			]
		},
		{
			"question":
			{
				"en": "Who was the physician who traveled with Paul and wrote Acts?",
				"pt": "Who was the physician who traveled with Paul and wrote Acts?"
			},
			"answer": {"en": "Luke", "pt": "Luke"},
			"tier": 1,
			"decoys":
			[
				{"en": "Mark", "pt": "Mark"},
				{"en": "Titus", "pt": "Titus"},
				{"en": "Silas", "pt": "Silas"}
			]
		},
		{
			"question":
			{
				"en": "Where did Paul spend two years in a rented house under guard?",
				"pt": "Where did Paul spend two years in a rented house under guard?"
			},
			"answer": {"en": "Rome", "pt": "Rome"},
			"tier": 2,
			"decoys":
			[
				{"en": "Antioch", "pt": "Antioch"},
				{"en": "Caesarea", "pt": "Caesarea"},
				{"en": "Corinth", "pt": "Corinth"}
			]
		},
		{
			"question":
			{
				"en": "What harbor in Crete was considered unsuitable to winter in?",
				"pt": "What harbor in Crete was considered unsuitable to winter in?"
			},
			"answer": {"en": "Fair Havens", "pt": "Fair Havens"},
			"tier": 3,
			"decoys":
			[
				{"en": "Phoenix", "pt": "Phoenix"},
				{"en": "Alexandria", "pt": "Alexandria"},
				{"en": "Myra", "pt": "Myra"}
			]
		},
		{
			"question":
			{
				"en": "What was 'the Fast' already past when they set sail in Acts 27?",
				"pt": "What was 'the Fast' already past when they set sail in Acts 27?"
			},
			"answer": {"en": "The Day of Atonement", "pt": "The Day of Atonement"},
			"tier": 3,
			"decoys":
			[
				{"en": "Passover", "pt": "Passover"},
				{"en": "Pentecost", "pt": "Pentecost"},
				{"en": "Purim", "pt": "Purim"}
			]
		},
		{
			"question":
			{
				"en": "What inscription on an Athenian altar did Paul reference?",
				"pt": "What inscription on an Athenian altar did Paul reference?"
			},
			"answer": {"en": "To an unknown god", "pt": "To an unknown god"},
			"tier": 3,
			"decoys":
			[
				{"en": "To the gods of Olympus", "pt": "To the gods of Olympus"},
				{"en": "To Mars", "pt": "To Mars"},
				{"en": "To the imperial spirit", "pt": "To the imperial spirit"}
			]
		},
		{
			"question":
			{
				"en": "How long did Paul spend on Malta after the shipwreck?",
				"pt": "How long did Paul spend on Malta after the shipwreck?"
			},
			"answer": {"en": "Three months", "pt": "Three months"},
			"tier": 3,
			"decoys":
			[
				{"en": "Ten days", "pt": "Ten days"},
				{"en": "Six months", "pt": "Six months"},
				{"en": "One week", "pt": "One week"}
			]
		},
		{
			"question":
			{
				"en": "Who was the chief official of Malta whose father Paul healed?",
				"pt": "Who was the chief official of Malta whose father Paul healed?"
			},
			"answer": {"en": "Publius", "pt": "Publius"},
			"tier": 3,
			"decoys":
			[
				{"en": "Sergius Paulus", "pt": "Sergius Paulus"},
				{"en": "Eutychus", "pt": "Eutychus"},
				{"en": "Gaius", "pt": "Gaius"}
			]
		},
		{
			"question":
			{
				"en": "In which city did Paul reason for three Sabbaths causing jealousy?",
				"pt": "In which city did Paul reason for three Sabbaths causing jealousy?"
			},
			"answer": {"en": "Thessalonica", "pt": "Thessalonica"},
			"tier": 3,
			"decoys":
			[
				{"en": "Berea", "pt": "Berea"},
				{"en": "Athens", "pt": "Athens"},
				{"en": "Derbe", "pt": "Derbe"}
			]
		},
		{
			"question":
			{
				"en": "Whom did Paul circumcise to avoid offending Jews?",
				"pt": "Whom did Paul circumcise to avoid offending Jews?"
			},
			"answer": {"en": "Timothy", "pt": "Timothy"},
			"tier": 3,
			"decoys":
			[
				{"en": "Titus", "pt": "Titus"},
				{"en": "Silas", "pt": "Silas"},
				{"en": "Luke", "pt": "Luke"}
			]
		},
		{
			"question":
			{
				"en": "Which proconsul dismissed the case against Paul in Corinth?",
				"pt": "Which proconsul dismissed the case against Paul in Corinth?"
			},
			"answer": {"en": "Gallio", "pt": "Gallio"},
			"tier": 3,
			"decoys":
			[
				{"en": "Felix", "pt": "Felix"},
				{"en": "Festus", "pt": "Festus"},
				{"en": "Lysias", "pt": "Lysias"}
			]
		}
	],
	"Letters of Paul":
	[
		{
			"question":
			{
				"en": "Which letter teaches justification by faith for Jew and Gentile?",
				"pt": "Qual carta ensina a justificação pela fé para judeus e gentios?"
			},
			"answer": {"en": "Romans", "pt": "Romanos"},
			"tier": 2,
			"decoys":
			[
				{"en": "Galatians", "pt": "Gálatas"},
				{"en": "Ephesians", "pt": "Efésios"},
				{"en": "Philippians", "pt": "Filipenses"}
			]
		},
		{
			"question":
			{
				"en": "Which chapter is known as the love chapter?",
				"pt": "Qual capítulo é conhecido como capítulo do amor?"
			},
			"answer": {"en": "1 Corinthians 13", "pt": "1 Coríntios 13"},
			"tier": 1,
			"decoys":
			[
				{"en": "Romans 8", "pt": "Romanos 8"},
				{"en": "John 3", "pt": "João 3"},
				{"en": "1 John 4", "pt": "1 João 4"}
			]
		},
		{
			"question":
			{
				"en": "Where is the armor of God described?",
				"pt": "Onde é descrita a armadura de Deus?"
			},
			"answer": {"en": "Ephesians 6", "pt": "Efésios 6"},
			"tier": 1,
			"decoys":
			[
				{"en": "Romans 12", "pt": "Romanos 12"},
				{"en": "Colossians 3", "pt": "Colossenses 3"},
				{"en": "1 Peter 5", "pt": "1 Pedro 5"}
			]
		},
		{
			"question":
			{
				"en": "Which letter lists the fruit of the Spirit?",
				"pt": "Qual carta lista o fruto do Espírito?"
			},
			"answer": {"en": "Galatians", "pt": "Gálatas"},
			"tier": 1,
			"decoys":
			[
				{"en": "Colossians", "pt": "Colossenses"},
				{"en": "Philippians", "pt": "Filipenses"},
				{"en": "Thessalonians", "pt": "Tessalonicenses"}
			]
		},
		{
			"question":
			{
				"en": "Which letter repeats 'Rejoice in the Lord always'?",
				"pt": "Qual letra repete 'Alegrai-vos sempre no Senhor'?"
			},
			"answer": {"en": "Philippians", "pt": "Filipenses"},
			"tier": 1,
			"decoys":
			[
				{"en": "Colossians", "pt": "Colossenses"},
				{"en": "Ephesians", "pt": "Efésios"},
				{"en": "Philemon", "pt": "Filemom"}
			]
		},
		{
			"question":
			{
				"en": "Which letter tells believers their bodies are temples of the Holy Spirit?",
				"pt": "Qual carta diz aos crentes que seus corpos são templos do Espírito Santo?"
			},
			"answer": {"en": "1 Corinthians", "pt": "1 Coríntios"},
			"tier": 1,
			"decoys":
			[
				{"en": "2 Corinthians", "pt": "2 Coríntios"},
				{"en": "Romans", "pt": "Romanos"},
				{"en": "Colossians", "pt": "Colossenses"}
			]
		},
		{
			"question":
			{
				"en": "Which letter gives qualifications for overseers and deacons?",
				"pt": "Qual carta dá qualificações para superintendentes e diáconos?"
			},
			"answer": {"en": "1 Timothy", "pt": "1 Timóteo"},
			"tier": 1,
			"decoys":
			[
				{"en": "2 Timothy", "pt": "2 Timóteo"},
				{"en": "Titus", "pt": "Tito"},
				{"en": "2 Thessalonians", "pt": "2 Tessalonicenses"}
			]
		},
		{
			"question":
			{
				"en":
				"Which letter contains the hymn about Christ emptying Himself and taking on servanthood?",
				"pt": "Qual carta contém o hino sobre Cristo se esvaziando e assumindo a servidão?"
			},
			"answer": {"en": "Philippians", "pt": "Filipenses"},
			"tier": 2,
			"decoys":
			[
				{"en": "Colossians", "pt": "Colossenses"},
				{"en": "Galatians", "pt": "Gálatas"},
				{"en": "Romans", "pt": "Romanos"}
			]
		},
		{
			"question":
			{
				"en": "Which letter asks, 'Who has bewitched you?'",
				"pt": "Qual carta pergunta: 'Quem enfeitiçou você?'"
			},
			"answer": {"en": "Galatians", "pt": "Gálatas"},
			"tier": 1,
			"decoys":
			[
				{"en": "Philippians", "pt": "Filipenses"},
				{"en": "Ephesians", "pt": "Efésios"},
				{"en": "Colossians", "pt": "Colossenses"}
			]
		},
		{
			"question":
			{
				"en":
				"Which letter comforts a church about those who have fallen asleep and Christ's return?",
				"pt":
				"Qual carta conforta uma igreja sobre aqueles que adormeceram e o retorno de Cristo?"
			},
			"answer": {"en": "1 Thessalonians", "pt": "1 Tessalonicenses"},
			"tier": 1,
			"decoys":
			[
				{"en": "Galatians", "pt": "Gálatas"},
				{"en": "Ephesians", "pt": "Efésios"},
				{"en": "Philemon", "pt": "Filemom"}
			]
		},
		{
			"question":
			{
				"en": "Which letter describes the man of lawlessness being revealed?",
				"pt": "Qual carta descreve o homem que é iníquo sendo revelado?"
			},
			"answer": {"en": "2 Thessalonians", "pt": "2 Tessalonicenses"},
			"tier": 2,
			"decoys":
			[
				{"en": "1 Corinthians", "pt": "1 Coríntios"},
				{"en": "Colossians", "pt": "Colossenses"},
				{"en": "Romans", "pt": "Romanos"}
			]
		},
		{
			"question":
			{
				"en": "Which brief letter asks a master to receive Onesimus as a brother?",
				"pt": "Qual breve carta pede a um mestre que receba Onésimo como irmão?"
			},
			"answer": {"en": "Philemon", "pt": "Filemom"},
			"tier": 2,
			"decoys":
			[
				{"en": "Titus", "pt": "Tito"},
				{"en": "2 Timothy", "pt": "2 Timóteo"},
				{"en": "Hebrews", "pt": "Hebreus"}
			]
		},
		{
			"question":
			{
				"en": "Which letter exalts Christ as the image of the invisible God?",
				"pt": "Qual carta exalta Cristo como a imagem do Deus invisível?"
			},
			"answer": {"en": "Colossians", "pt": "Colossenses"},
			"tier": 2,
			"decoys":
			[
				{"en": "Ephesians", "pt": "Efésios"},
				{"en": "Romans", "pt": "Romanos"},
				{"en": "Hebrews", "pt": "Hebreus"}
			]
		},
		{
			"question":
			{
				"en": "Which letter urges appointing elders in every town on Crete?",
				"pt": "Que carta exorta à nomeação de presbíteros em todas as cidades de Creta?"
			},
			"answer": {"en": "Titus", "pt": "Tito"},
			"tier": 2,
			"decoys":
			[
				{"en": "1 Timothy", "pt": "1 Timóteo"},
				{"en": "2 Thessalonians", "pt": "2 Tessalonicenses"},
				{"en": "Philemon", "pt": "Filemom"}
			]
		},
		{
			"question":
			{
				"en": "Which letter urges believers to present their bodies as living sacrifices?",
				"pt":
				"Qual carta exorta os crentes a apresentarem seus corpos como sacrifícios vivos?"
			},
			"answer": {"en": "Romans", "pt": "Romanos"},
			"tier": 1,
			"decoys":
			[
				{"en": "Ephesians", "pt": "Efésios"},
				{"en": "1 Peter", "pt": "1 Pedro"},
				{"en": "Hebrews", "pt": "Hebreus"}
			]
		},
		{
			"question":
			{
				"en": "Which letter states 'All Scripture is God-breathed'?",
				"pt": "Qual carta afirma 'Toda a Escritura é inspirada por Deus'?"
			},
			"answer": {"en": "2 Timothy", "pt": "2 Timóteo"},
			"tier": 2,
			"decoys":
			[
				{"en": "1 Timothy", "pt": "1 Timóteo"},
				{"en": "Galatians", "pt": "Gálatas"},
				{"en": "Acts", "pt": "Atos"}
			]
		},
		{
			"question":
			{
				"en":
				"Which letter defends Paul's ministry and urges cheerful giving for the Jerusalem saints?",
				"pt":
				"Qual carta defende o ministério de Paulo e recomenda doações alegres aos santos de Jerusalém?"
			},
			"answer": {"en": "2 Corinthians", "pt": "2 Coríntios"},
			"tier": 2,
			"decoys":
			[
				{"en": "1 Corinthians", "pt": "1 Coríntios"},
				{"en": "Philippians", "pt": "Filipenses"},
				{"en": "1 Thessalonians", "pt": "1 Tessalonicenses"}
			]
		},
		{
			"question":
			{
				"en":
				"Which letter celebrates one body and one Spirit, one Lord, one faith, one baptism?",
				"pt": "Qual carta celebra um corpo e um Espírito, um Senhor, uma fé, um batismo?"
			},
			"answer": {"en": "Ephesians", "pt": "Efésios"},
			"tier": 2,
			"decoys":
			[
				{"en": "Galatians", "pt": "Gálatas"},
				{"en": "James", "pt": "James"},
				{"en": "1 Peter", "pt": "1 Pedro"}
			]
		},
		{
			"question":
			{
				"en":
				"Which letter tells believers to set their minds on things above, not on earthly things?",
				"pt":
				"Qual carta diz aos crentes para fixarem suas mentes nas coisas do alto, e não nas coisas terrenas?"
			},
			"answer": {"en": "Colossians", "pt": "Colossenses"},
			"tier": 2,
			"decoys":
			[
				{"en": "Philippians", "pt": "Filipenses"},
				{"en": "1 Thessalonians", "pt": "1 Tessalonicenses"},
				{"en": "James", "pt": "James"}
			]
		},
		{
			"question":
			{
				"en": "Which letter warns that the love of money is a root of all kinds of evil?",
				"pt":
				"Qual carta alerta que o amor ao dinheiro é a raiz de todos os tipos de males?"
			},
			"answer": {"en": "1 Timothy", "pt": "1 Timóteo"},
			"tier": 1,
			"decoys":
			[
				{"en": "2 Thessalonians", "pt": "2 Tessalonicenses"},
				{"en": "2 Peter", "pt": "2 Pedro"},
				{"en": "Colossians", "pt": "Colossenses"}
			]
		},
		{
			"question":
			{
				"en":
				"Which letter mentions Paul's thorn and hears 'My grace is sufficient for you'?",
				"pt":
				"Which letter mentions Paul's thorn and hears 'My grace is sufficient for you'?"
			},
			"answer": {"en": "2 Corinthians", "pt": "2 Corinthians"},
			"tier": 3,
			"decoys":
			[
				{"en": "Romans", "pt": "Romans"},
				{"en": "Galatians", "pt": "Galatians"},
				{"en": "Ephesians", "pt": "Ephesians"}
			]
		},
		{
			"question":
			{
				"en": "Which letter uses an olive tree to picture Gentiles grafted in?",
				"pt": "Which letter uses an olive tree to picture Gentiles grafted in?"
			},
			"answer": {"en": "Romans", "pt": "Romans"},
			"tier": 3,
			"decoys":
			[
				{"en": "Philippians", "pt": "Philippians"},
				{"en": "Colossians", "pt": "Colossians"},
				{"en": "Titus", "pt": "Titus"}
			]
		},
		{
			"question":
			{
				"en": "Which letter asks the recipient to prepare a guest room for Paul?",
				"pt": "Which letter asks the recipient to prepare a guest room for Paul?"
			},
			"answer": {"en": "Philemon", "pt": "Philemon"},
			"tier": 3,
			"decoys":
			[
				{"en": "1 Timothy", "pt": "1 Timothy"},
				{"en": "2 Thessalonians", "pt": "2 Thessalonians"},
				{"en": "Hebrews", "pt": "Hebrews"}
			]
		},
		{
			"question":
			{
				"en": "Which letter urges believers to live quietly and work with their hands?",
				"pt": "Which letter urges believers to live quietly and work with their hands?"
			},
			"answer": {"en": "1 Thessalonians", "pt": "1 Thessalonians"},
			"tier": 3,
			"decoys":
			[
				{"en": "Galatians", "pt": "Galatians"},
				{"en": "Ephesians", "pt": "Ephesians"},
				{"en": "1 Corinthians", "pt": "1 Corinthians"}
			]
		},
		{
			"question":
			{
				"en": "Which letter mentions Epaphroditus risking his life to serve Paul?",
				"pt": "Which letter mentions Epaphroditus risking his life to serve Paul?"
			},
			"answer": {"en": "Philippians", "pt": "Philippians"},
			"tier": 3,
			"decoys":
			[
				{"en": "Colossians", "pt": "Colossians"},
				{"en": "2 Timothy", "pt": "2 Timothy"},
				{"en": "Romans", "pt": "Romans"}
			]
		},
		{
			"question":
			{
				"en": "Which letter warns about those who forbid marriage and certain foods?",
				"pt": "Which letter warns about those who forbid marriage and certain foods?"
			},
			"answer": {"en": "1 Timothy", "pt": "1 Timothy"},
			"tier": 3,
			"decoys":
			[
				{"en": "Titus", "pt": "Titus"},
				{"en": "Galatians", "pt": "Galatians"},
				{"en": "2 Corinthians", "pt": "2 Corinthians"}
			]
		},
		{
			"question":
			{
				"en": "Which letter asks Timothy to bring Paul's cloak and scrolls left at Troas?",
				"pt": "Which letter asks Timothy to bring Paul's cloak and scrolls left at Troas?"
			},
			"answer": {"en": "2 Timothy", "pt": "2 Timothy"},
			"tier": 3,
			"decoys":
			[
				{"en": "1 Timothy", "pt": "1 Timothy"},
				{"en": "Philemon", "pt": "Philemon"},
				{"en": "Hebrews", "pt": "Hebrews"}
			]
		},
		{
			"question":
			{
				"en": "Which letter says to read also the letter from Laodicea?",
				"pt": "Which letter says to read also the letter from Laodicea?"
			},
			"answer": {"en": "Colossians", "pt": "Colossians"},
			"tier": 3,
			"decoys":
			[
				{"en": "Ephesians", "pt": "Ephesians"},
				{"en": "Philippians", "pt": "Philippians"},
				{"en": "2 Thessalonians", "pt": "2 Thessalonians"}
			]
		},
		{
			"question":
			{
				"en":
				"Which letter commands husbands to love their wives as Christ loved the church?",
				"pt":
				"Which letter commands husbands to love their wives as Christ loved the church?"
			},
			"answer": {"en": "Ephesians", "pt": "Ephesians"},
			"tier": 3,
			"decoys":
			[
				{"en": "Galatians", "pt": "Galatians"},
				{"en": "Romans", "pt": "Romans"},
				{"en": "1 Timothy", "pt": "1 Timothy"}
			]
		},
		{
			"question":
			{
				"en": "Which letter declares there is no condemnation for those in Christ Jesus?",
				"pt": "Which letter declares there is no condemnation for those in Christ Jesus?"
			},
			"answer": {"en": "Romans", "pt": "Romans"},
			"tier": 3,
			"decoys":
			[
				{"en": "1 Thessalonians", "pt": "1 Thessalonians"},
				{"en": "Titus", "pt": "Titus"},
				{"en": "Philemon", "pt": "Philemon"}
			]
		}
	],
	"Churches in Revelation":
	[
		{
			"question":
			{
				"en": "On which island did John receive Revelation?",
				"pt": "Em que ilha João recebeu o Apocalipse?"
			},
			"answer": {"en": "Patmos", "pt": "Patmos"},
			"tier": 1,
			"decoys":
			[
				{"en": "Cyprus", "pt": "Chipre"},
				{"en": "Crete", "pt": "Creta"},
				{"en": "Rhodes", "pt": "Rodes"}
			]
		},
		{
			"question":
			{
				"en": "Which church was lukewarm and told to repent?",
				"pt": "Qual igreja foi morna e foi instruída a se arrepender?"
			},
			"answer": {"en": "Laodicea", "pt": "Laodicéia"},
			"tier": 2,
			"decoys":
			[
				{"en": "Sardis", "pt": "Sardes"},
				{"en": "Ephesus", "pt": "Éfeso"},
				{"en": "Pergamum", "pt": "Pérgamo"}
			]
		},
		{
			"question":
			{
				"en": "Which church was known for its first love growing cold?",
				"pt": "Qual igreja foi conhecida por seu primeiro amor esfriar?"
			},
			"answer": {"en": "Ephesus", "pt": "Éfeso"},
			"tier": 1,
			"decoys":
			[
				{"en": "Smyrna", "pt": "Esmirna"},
				{"en": "Philadelphia", "pt": "Filadélfia"},
				{"en": "Thyatira", "pt": "Tiatira"}
			]
		},
		{
			"question":
			{
				"en": "Which church had an open door no one could shut?",
				"pt": "Qual igreja tinha uma porta aberta que ninguém conseguia fechar?"
			},
			"answer": {"en": "Philadelphia", "pt": "Filadélfia"},
			"tier": 1,
			"decoys":
			[
				{"en": "Smyrna", "pt": "Esmirna"},
				{"en": "Sardis", "pt": "Sardes"},
				{"en": "Pergamum", "pt": "Pérgamo"}
			]
		},
		{
			"question":
			{
				"en": "How many churches received letters in Revelation?",
				"pt": "Quantas igrejas receberam cartas em Apocalipse?"
			},
			"answer": {"en": "Seven", "pt": "Sete"},
			"tier": 1,
			"decoys":
			[
				{"en": "Five", "pt": "Cinco"},
				{"en": "Six", "pt": "Seis"},
				{"en": "Eight", "pt": "Oito"}
			]
		},
		{
			"question":
			{
				"en": "Which church was poor yet spiritually rich?",
				"pt": "Qual igreja era pobre, mas espiritualmente rica?"
			},
			"answer": {"en": "Smyrna", "pt": "Esmirna"},
			"tier": 1,
			"decoys":
			[
				{"en": "Laodicea", "pt": "Laodicéia"},
				{"en": "Ephesus", "pt": "Éfeso"},
				{"en": "Thyatira", "pt": "Tiatira"}
			]
		},
		{
			"question":
			{
				"en": "Which church lived where 'Satan's throne' was and held fast Jesus' name?",
				"pt":
				"Qual igreja viveu onde estava o “trono de Satanás” e manteve firme o nome de Jesus?"
			},
			"answer": {"en": "Pergamum", "pt": "Pérgamo"},
			"tier": 2,
			"decoys":
			[
				{"en": "Sardis", "pt": "Sardes"},
				{"en": "Smyrna", "pt": "Esmirna"},
				{"en": "Philadelphia", "pt": "Filadélfia"}
			]
		},
		{
			"question":
			{
				"en": "Which church tolerated a woman called Jezebel who misled servants?",
				"pt": "Qual igreja tolerou uma mulher chamada Jezabel que enganava os servos?"
			},
			"answer": {"en": "Thyatira", "pt": "Tiatira"},
			"tier": 2,
			"decoys":
			[
				{"en": "Philadelphia", "pt": "Filadélfia"},
				{"en": "Pergamum", "pt": "Pérgamo"},
				{"en": "Laodicea", "pt": "Laodicéia"}
			]
		},
		{
			"question":
			{
				"en": "Which church had a reputation for being alive but was dead?",
				"pt": "Qual igreja tinha a reputação de estar viva, mas estava morta?"
			},
			"answer": {"en": "Sardis", "pt": "Sardes"},
			"tier": 1,
			"decoys":
			[
				{"en": "Philadelphia", "pt": "Filadélfia"},
				{"en": "Smyrna", "pt": "Esmirna"},
				{"en": "Thyatira", "pt": "Tiatira"}
			]
		},
		{
			"question":
			{
				"en":
				"Which church was admonished to be faithful unto death for the crown of life?",
				"pt": "Qual igreja foi admoestada a ser fiel até a morte pela coroa da vida?"
			},
			"answer": {"en": "Smyrna", "pt": "Esmirna"},
			"tier": 2,
			"decoys":
			[
				{"en": "Laodicea", "pt": "Laodicéia"},
				{"en": "Sardis", "pt": "Sardes"},
				{"en": "Pergamum", "pt": "Pérgamo"}
			]
		},
		{
			"question":
			{
				"en": "Which church was urged to buy gold refined in fire and eye salve?",
				"pt": "Qual igreja foi instada a comprar ouro refinado em fogo e colírio?"
			},
			"answer": {"en": "Laodicea", "pt": "Laodicéia"},
			"tier": 2,
			"decoys":
			[
				{"en": "Smyrna", "pt": "Esmirna"},
				{"en": "Ephesus", "pt": "Éfeso"},
				{"en": "Pergamum", "pt": "Pérgamo"}
			]
		},
		{
			"question":
			{
				"en":
				"Which church was promised to be kept from the hour of trial coming on the world?",
				"pt":
				"Qual igreja foi prometida para ser guardada na hora da provação que sobreviria ao mundo?"
			},
			"answer": {"en": "Philadelphia", "pt": "Filadélfia"},
			"tier": 3,
			"decoys":
			[
				{"en": "Ephesus", "pt": "Éfeso"},
				{"en": "Thyatira", "pt": "Tiatira"},
				{"en": "Laodicea", "pt": "Laodicéia"}
			]
		},
		{
			"question":
			{
				"en":
				"Which church was told to wake up so their soiled clothes could become white?",
				"pt":
				"Qual igreja foi instruída a acordar para que suas roupas sujas ficassem brancas?"
			},
			"answer": {"en": "Sardis", "pt": "Sardes"},
			"tier": 2,
			"decoys":
			[
				{"en": "Ephesus", "pt": "Éfeso"},
				{"en": "Laodicea", "pt": "Laodicéia"},
				{"en": "Smyrna", "pt": "Esmirna"}
			]
		},
		{
			"question":
			{
				"en": "Which church was praised that its latter works exceeded the first?",
				"pt": "Qual igreja foi elogiada porque suas últimas obras excederam as primeiras?"
			},
			"answer": {"en": "Thyatira", "pt": "Tiatira"},
			"tier": 3,
			"decoys":
			[
				{"en": "Ephesus", "pt": "Éfeso"},
				{"en": "Sardis", "pt": "Sardes"},
				{"en": "Pergamum", "pt": "Pérgamo"}
			]
		},
		{
			"question":
			{
				"en":
				"Which church was rebuked for some holding the teaching of Balaam and the Nicolaitans?",
				"pt":
				"Qual igreja foi repreendida por alguns seguirem os ensinamentos de Balaão e dos nicolaítas?"
			},
			"answer": {"en": "Pergamum", "pt": "Pérgamo"},
			"tier": 2,
			"decoys":
			[
				{"en": "Ephesus", "pt": "Éfeso"},
				{"en": "Smyrna", "pt": "Esmirna"},
				{"en": "Philadelphia", "pt": "Filadélfia"}
			]
		},
		{
			"question":
			{
				"en": "Which church was promised hidden manna and a white stone with a new name?",
				"pt":
				"A qual igreja foi prometido o maná escondido e uma pedra branca com um novo nome?"
			},
			"answer": {"en": "Pergamum", "pt": "Pérgamo"},
			"tier": 3,
			"decoys":
			[
				{"en": "Sardis", "pt": "Sardes"},
				{"en": "Thyatira", "pt": "Tiatira"},
				{"en": "Laodicea", "pt": "Laodicéia"}
			]
		},
		{
			"question":
			{
				"en": "Which church was promised to sit with Jesus on His throne if they overcame?",
				"pt": "A qual igreja foi prometido sentar-se com Jesus em Seu trono se vencesse?"
			},
			"answer": {"en": "Laodicea", "pt": "Laodicéia"},
			"tier": 2,
			"decoys":
			[
				{"en": "Philadelphia", "pt": "Filadélfia"},
				{"en": "Smyrna", "pt": "Esmirna"},
				{"en": "Ephesus", "pt": "Éfeso"}
			]
		},
		{
			"question":
			{
				"en":
				"Which church was commended for keeping Jesus' word and not denying His name though they had little strength?",
				"pt":
				"Qual igreja foi elogiada por guardar a palavra de Jesus e não negar Seu nome, embora tivessem pouca força?"
			},
			"answer": {"en": "Philadelphia", "pt": "Filadélfia"},
			"tier": 2,
			"decoys":
			[
				{"en": "Pergamum", "pt": "Pérgamo"},
				{"en": "Thyatira", "pt": "Tiatira"},
				{"en": "Ephesus", "pt": "Éfeso"}
			]
		},
		{
			"question":
			{
				"en": "Which two churches received only praise and no rebuke?",
				"pt":
				"Quais foram as duas igrejas que receberam apenas elogios e nenhuma repreensão?"
			},
			"answer": {"en": "Smyrna and Philadelphia", "pt": "Esmirna e Filadélfia"},
			"tier": 3,
			"decoys":
			[
				{"en": "Pergamum and Thyatira", "pt": "Pérgamo e Tiatira"},
				{"en": "Ephesus and Laodicea", "pt": "Éfeso e Laodicéia"},
				{"en": "Sardis and Pergamum", "pt": "Sardes e Pérgamo"}
			]
		},
		{
			"question":
			{
				"en":
				"Which church was told to remember what they had received and heard, and hold it fast?",
				"pt":
				"A qual igreja foi dito que se lembrasse do que havia recebido e ouvido e que se mantivesse firme?"
			},
			"answer": {"en": "Sardis", "pt": "Sardes"},
			"tier": 2,
			"decoys":
			[
				{"en": "Philadelphia", "pt": "Filadélfia"},
				{"en": "Thyatira", "pt": "Tiatira"},
				{"en": "Laodicea", "pt": "Laodicéia"}
			]
		},
		{
			"question":
			{
				"en": "Who spoke the messages to the seven churches to John?",
				"pt": "Who spoke the messages to the seven churches to John?"
			},
			"answer": {"en": "Jesus, the risen Son of Man", "pt": "Jesus, the risen Son of Man"},
			"tier": 1,
			"decoys":
			[
				{"en": "Paul", "pt": "Paul"},
				{"en": "An angel", "pt": "An angel"},
				{"en": "Moses", "pt": "Moses"}
			]
		},
		{
			"question":
			{
				"en": "In which chapters of Revelation are the letters to the churches found?",
				"pt": "In which chapters of Revelation are the letters to the churches found?"
			},
			"answer": {"en": "Chapters 2 and 3", "pt": "Chapters 2 and 3"},
			"tier": 1,
			"decoys":
			[
				{"en": "Chapters 6 and 7", "pt": "Chapters 6 and 7"},
				{"en": "Chapter 1 only", "pt": "Chapter 1 only"},
				{"en": "Chapters 10 and 11", "pt": "Chapters 10 and 11"}
			]
		},
		{
			"question":
			{
				"en": "What do the seven stars in Jesus' hand represent?",
				"pt": "What do the seven stars in Jesus' hand represent?"
			},
			"answer":
			{"en": "The angels of the seven churches", "pt": "The angels of the seven churches"},
			"tier": 1,
			"decoys":
			[
				{"en": "The twelve tribes", "pt": "The twelve tribes"},
				{"en": "The seven hills", "pt": "The seven hills"},
				{"en": "The seven seals", "pt": "The seven seals"}
			]
		},
		{
			"question":
			{
				"en": "What do the seven golden lampstands represent?",
				"pt": "What do the seven golden lampstands represent?"
			},
			"answer": {"en": "The seven churches", "pt": "The seven churches"},
			"tier": 1,
			"decoys":
			[
				{"en": "Seven feasts", "pt": "Seven feasts"},
				{"en": "Seven spirits", "pt": "Seven spirits"},
				{"en": "Seven crowns", "pt": "Seven crowns"}
			]
		},
		{
			"question":
			{
				"en":
				"Which church was warned Jesus would come like a thief if they did not wake up?",
				"pt":
				"Which church was warned Jesus would come like a thief if they did not wake up?"
			},
			"answer": {"en": "Sardis", "pt": "Sardis"},
			"tier": 3,
			"decoys":
			[
				{"en": "Laodicea", "pt": "Laodicea"},
				{"en": "Smyrna", "pt": "Smyrna"},
				{"en": "Pergamum", "pt": "Pergamum"}
			]
		},
		{
			"question":
			{
				"en": "Which church was warned that Jesus would fight with the sword of His mouth?",
				"pt": "Which church was warned that Jesus would fight with the sword of His mouth?"
			},
			"answer": {"en": "Pergamum", "pt": "Pergamum"},
			"tier": 3,
			"decoys":
			[
				{"en": "Thyatira", "pt": "Thyatira"},
				{"en": "Sardis", "pt": "Sardis"},
				{"en": "Philadelphia", "pt": "Philadelphia"}
			]
		},
		{
			"question":
			{
				"en": "Which church was promised authority over nations and the morning star?",
				"pt": "Which church was promised authority over nations and the morning star?"
			},
			"answer": {"en": "Thyatira", "pt": "Thyatira"},
			"tier": 3,
			"decoys":
			[
				{"en": "Ephesus", "pt": "Ephesus"},
				{"en": "Sardis", "pt": "Sardis"},
				{"en": "Laodicea", "pt": "Laodicea"}
			]
		},
		{
			"question":
			{
				"en":
				"Which church was promised to be a pillar in God's temple with His name written on them?",
				"pt":
				"Which church was promised to be a pillar in God's temple with His name written on them?"
			},
			"answer": {"en": "Philadelphia", "pt": "Philadelphia"},
			"tier": 3,
			"decoys":
			[
				{"en": "Ephesus", "pt": "Ephesus"},
				{"en": "Pergamum", "pt": "Pergamum"},
				{"en": "Smyrna", "pt": "Smyrna"}
			]
		},
		{
			"question":
			{
				"en":
				"Which church was promised that Jesus would dine with anyone who opened the door?",
				"pt":
				"Which church was promised that Jesus would dine with anyone who opened the door?"
			},
			"answer": {"en": "Laodicea", "pt": "Laodicea"},
			"tier": 3,
			"decoys":
			[
				{"en": "Ephesus", "pt": "Ephesus"},
				{"en": "Sardis", "pt": "Sardis"},
				{"en": "Smyrna", "pt": "Smyrna"}
			]
		},
		{
			"question":
			{
				"en": "Which church was told some would suffer tribulation ten days?",
				"pt": "Which church was told some would suffer tribulation ten days?"
			},
			"answer": {"en": "Smyrna", "pt": "Smyrna"},
			"tier": 3,
			"decoys":
			[
				{"en": "Philadelphia", "pt": "Philadelphia"},
				{"en": "Laodicea", "pt": "Laodicea"},
				{"en": "Thyatira", "pt": "Thyatira"}
			]
		}
	],
	"Bible Geography":
	[
		{
			"question":
			{"en": "Which river flows into the Dead Sea?", "pt": "Qual rio deságua no Mar Morto?"},
			"answer": {"en": "The Jordan River", "pt": "O rio Jordão"},
			"tier": 1,
			"decoys":
			[
				{"en": "The Arnon", "pt": "O Arnon"},
				{"en": "The Pharpar", "pt": "O Farpar"},
				{"en": "The Euphrates", "pt": "O Eufrates"}
			]
		},
		{
			"question":
			{
				"en": "What lake is also called the Sea of Galilee?",
				"pt": "Que lago também é chamado de Mar da Galiléia?"
			},
			"answer": {"en": "Lake Gennesaret", "pt": "Lago Genesaré"},
			"tier": 2,
			"decoys":
			[
				{"en": "Lake Tiberias", "pt": "Lago Tiberíades"},
				{"en": "Lake Huleh", "pt": "Lago Huléh"},
				{"en": "Lake Merom", "pt": "Lago Merom"}
			]
		},
		{
			"question":
			{
				"en": "Where did Moses receive the Ten Commandments?",
				"pt": "Onde Moisés recebeu os Dez Mandamentos?"
			},
			"answer": {"en": "Mount Sinai", "pt": "Monte Sinai"},
			"tier": 1,
			"decoys":
			[
				{"en": "Mount Horeb", "pt": "Monte Horebe"},
				{"en": "Mount Nebo", "pt": "Monte Nebo"},
				{"en": "Mount Zion", "pt": "Monte Sião"}
			]
		},
		{
			"question":
			{"en": "In which town was Jesus raised?", "pt": "Em que cidade Jesus foi criado?"},
			"answer": {"en": "Nazareth", "pt": "Nazaré"},
			"tier": 1,
			"decoys":
			[
				{"en": "Bethlehem", "pt": "Belém"},
				{"en": "Capernaum", "pt": "Cafarnaum"},
				{"en": "Bethany", "pt": "Betânia"}
			]
		},
		{
			"question": {"en": "What does Bethlehem mean?", "pt": "O que Belém significa?"},
			"answer": {"en": "House of bread", "pt": "Casa de pão"},
			"tier": 2,
			"decoys":
			[
				{"en": "House of hope", "pt": "Casa da esperança"},
				{"en": "City of David", "pt": "Cidade de Davi"},
				{"en": "House of mercy", "pt": "Casa da misericórdia"}
			]
		},
		{
			"question":
			{
				"en": "Which sea did Israel cross when fleeing Egypt?",
				"pt": "Que mar Israel cruzou ao fugir do Egito?"
			},
			"answer": {"en": "The Red Sea", "pt": "O Mar Vermelho"},
			"tier": 1,
			"decoys":
			[
				{"en": "The Mediterranean Sea", "pt": "O Mar Mediterrâneo"},
				{"en": "The Sea of Galilee", "pt": "O Mar da Galileia"},
				{"en": "The Black Sea", "pt": "O Mar Negro"}
			]
		},
		{
			"question":
			{"en": "In which river was Jesus baptized?", "pt": "Em que rio Jesus foi batizado?"},
			"answer": {"en": "The Jordan River", "pt": "O rio Jordão"},
			"tier": 1,
			"decoys":
			[
				{"en": "The Nile", "pt": "O Nilo"},
				{"en": "The Tigris", "pt": "O Tigre"},
				{"en": "The Euphrates", "pt": "O Eufrates"}
			]
		},
		{
			"question":
			{
				"en": "In what valley did David face Goliath?",
				"pt": "Em que vale Davi enfrentou Golias?"
			},
			"answer": {"en": "The Valley of Elah", "pt": "O Vale de Elá"},
			"tier": 2,
			"decoys":
			[
				{"en": "The Kidron Valley", "pt": "O Vale do Cédron"},
				{"en": "The Valley of Jezreel", "pt": "O Vale de Jezreel"},
				{"en": "The Arnon Valley", "pt": "O Vale do Arnon"}
			]
		},
		{
			"question":
			{
				"en": "On which mountain did Elijah confront the prophets of Baal?",
				"pt": "Em que montanha Elias confrontou os profetas de Baal?"
			},
			"answer": {"en": "Mount Carmel", "pt": "Monte Carmelo"},
			"tier": 2,
			"decoys":
			[
				{"en": "Mount Tabor", "pt": "Monte Tabor"},
				{"en": "Mount Hermon", "pt": "Monte Hermom"},
				{"en": "Mount Gerizim", "pt": "Monte Gerizim"}
			]
		},
		{
			"question":
			{
				"en": "In which wilderness did Israel wander for forty years?",
				"pt": "Em que deserto Israel vagou durante quarenta anos?"
			},
			"answer": {"en": "The wilderness of Sinai", "pt": "O deserto do Sinai"},
			"tier": 2,
			"decoys":
			[
				{"en": "The Negev alone", "pt": "O Negev sozinho"},
				{"en": "The wilderness of Damascus", "pt": "O deserto de Damasco"},
				{"en": "The Arabian desert", "pt": "O deserto da Arábia"}
			]
		},
		{
			"question":
			{
				"en": "Which Syrian city sent Paul and Barnabas on their mission?",
				"pt": "Qual cidade síria enviou Paulo e Barnabé em missão?"
			},
			"answer": {"en": "Antioch of Syria", "pt": "Antioquia da Síria"},
			"tier": 2,
			"decoys":
			[
				{"en": "Damascus", "pt": "Damasco"},
				{"en": "Tyre", "pt": "Pneu"},
				{"en": "Sidon", "pt": "Sídon"}
			]
		},
		{
			"question":
			{
				"en": "Which town became Jesus' base of ministry in Galilee?",
				"pt": "Qual cidade se tornou a base do ministério de Jesus na Galiléia?"
			},
			"answer": {"en": "Capernaum", "pt": "Cafarnaum"},
			"tier": 1,
			"decoys":
			[
				{"en": "Bethany", "pt": "Betânia"},
				{"en": "Jericho", "pt": "Jericó"},
				{"en": "Hebron", "pt": "Hebrom"}
			]
		},
		{
			"question":
			{
				"en": "What river stopped flowing so Israel could cross into Canaan?",
				"pt": "Que rio parou de fluir para que Israel pudesse cruzar para Canaã?"
			},
			"answer": {"en": "The Jordan River", "pt": "O rio Jordão"},
			"tier": 2,
			"decoys":
			[
				{"en": "The Euphrates", "pt": "O Eufrates"},
				{"en": "The Nile", "pt": "O Nilo"},
				{"en": "The Kishon", "pt": "O Quisom"}
			]
		},
		{
			"question":
			{
				"en": "On what mountain did Abraham prepare to offer Isaac?",
				"pt": "Em que montanha Abraão se preparou para oferecer Isaque?"
			},
			"answer": {"en": "Mount Moriah", "pt": "Monte Moriá"},
			"tier": 2,
			"decoys":
			[
				{"en": "Mount Nebo", "pt": "Monte Nebo"},
				{"en": "Mount Carmel", "pt": "Monte Carmelo"},
				{"en": "Mount Bashan", "pt": "Monte Basã"}
			]
		},
		{
			"question":
			{
				"en": "Which ridge east of Jerusalem did Jesus often visit?",
				"pt": "Que cordilheira a leste de Jerusalém Jesus visitava com frequência?"
			},
			"answer": {"en": "The Mount of Olives", "pt": "O Monte das Oliveiras"},
			"tier": 1,
			"decoys":
			[
				{"en": "Mount Ebal", "pt": "Monte Ebal"},
				{"en": "Mount Ararat", "pt": "Monte Ararate"},
				{"en": "Mount Sinai", "pt": "Monte Sinai"}
			]
		},
		{
			"question":
			{
				"en": "Which salty lake sits about 1,300 feet below sea level?",
				"pt": "Qual lago salgado fica a cerca de 1.300 pés abaixo do nível do mar?"
			},
			"answer": {"en": "The Dead Sea", "pt": "O Mar Morto"},
			"tier": 2,
			"decoys":
			[
				{"en": "The Sea of Galilee", "pt": "O Mar da Galileia"},
				{"en": "Lake Huleh", "pt": "Lago Huléh"},
				{"en": "Lake Victoria", "pt": "Lago Vitória"}
			]
		},
		{
			"question":
			{
				"en": "Which plain is linked with the name Armageddon?",
				"pt": "Qual planície está ligada ao nome Armagedom?"
			},
			"answer": {"en": "The Valley of Megiddo", "pt": "O Vale de Megido"},
			"tier": 3,
			"decoys":
			[
				{"en": "The Plain of Dura", "pt": "A Planície de Dura"},
				{"en": "The Valley of Achor", "pt": "O Vale de Acor"},
				{"en": "The Valley of Kidron", "pt": "O Vale do Cedron"}
			]
		},
		{
			"question":
			{
				"en": "Where did Paul say farewell to the Ephesian elders?",
				"pt": "Onde Paulo se despediu dos anciãos de Éfeso?"
			},
			"answer": {"en": "Miletus", "pt": "Mileto"},
			"tier": 2,
			"decoys":
			[
				{"en": "Troas", "pt": "Trôade"},
				{"en": "Caesarea", "pt": "Cesaréia"},
				{"en": "Jerusalem", "pt": "Jerusalém"}
			]
		},
		{
			"question":
			{
				"en": "From which port did Jonah sail to flee God's call?",
				"pt": "De qual porto Jonas navegou para fugir do chamado de Deus?"
			},
			"answer": {"en": "Joppa", "pt": "Jope"},
			"tier": 1,
			"decoys":
			[
				{"en": "Tyre", "pt": "Pneu"},
				{"en": "Sidon", "pt": "Sídon"},
				{"en": "Ptolemais", "pt": "Ptolemaida"}
			]
		},
		{
			"question":
			{
				"en": "Which city is also called Zion in Scripture?",
				"pt": "Qual cidade também é chamada de Sião nas Escrituras?"
			},
			"answer": {"en": "Jerusalem", "pt": "Jerusalém"},
			"tier": 1,
			"decoys":
			[
				{"en": "Babylon", "pt": "Babilônia"},
				{"en": "Samaria", "pt": "Samaria"},
				{"en": "Bethel", "pt": "Betel"}
			]
		},
		{
			"question":
			{
				"en": "Which plain did Lot choose because it was well watered like Egypt?",
				"pt": "Which plain did Lot choose because it was well watered like Egypt?"
			},
			"answer": {"en": "The Jordan plain", "pt": "The Jordan plain"},
			"tier": 1,
			"decoys":
			[
				{"en": "The Jezreel Valley", "pt": "The Jezreel Valley"},
				{"en": "The Negev", "pt": "The Negev"},
				{"en": "The plains of Moab", "pt": "The plains of Moab"}
			]
		},
		{
			"question":
			{
				"en": "In which valley is Megiddo located, linked with Armageddon?",
				"pt": "In which valley is Megiddo located, linked with Armageddon?"
			},
			"answer": {"en": "The Jezreel Valley", "pt": "The Jezreel Valley"},
			"tier": 3,
			"decoys":
			[
				{"en": "Kidron Valley", "pt": "Kidron Valley"},
				{"en": "Hinnom Valley", "pt": "Hinnom Valley"},
				{"en": "Zered Valley", "pt": "Zered Valley"}
			]
		},
		{
			"question":
			{
				"en": "Which mountain opposite Mount Gerizim was used to pronounce curses?",
				"pt": "Which mountain opposite Mount Gerizim was used to pronounce curses?"
			},
			"answer": {"en": "Mount Ebal", "pt": "Mount Ebal"},
			"tier": 3,
			"decoys":
			[
				{"en": "Mount Tabor", "pt": "Mount Tabor"},
				{"en": "Mount Carmel", "pt": "Mount Carmel"},
				{"en": "Mount Nebo", "pt": "Mount Nebo"}
			]
		},
		{
			"question":
			{
				"en": "Which oasis near the Dead Sea sheltered David from Saul?",
				"pt": "Which oasis near the Dead Sea sheltered David from Saul?"
			},
			"answer": {"en": "En Gedi", "pt": "En Gedi"},
			"tier": 3,
			"decoys":
			[
				{"en": "Beersheba", "pt": "Beersheba"},
				{"en": "Ramah", "pt": "Ramah"},
				{"en": "Tekoa", "pt": "Tekoa"}
			]
		},
		{
			"question":
			{
				"en": "Which port city built by Herod served as Roman capital of Judea?",
				"pt": "Which port city built by Herod served as Roman capital of Judea?"
			},
			"answer": {"en": "Caesarea Maritima", "pt": "Caesarea Maritima"},
			"tier": 3,
			"decoys":
			[
				{"en": "Joppa", "pt": "Joppa"},
				{"en": "Tyre", "pt": "Tyre"},
				{"en": "Sidon", "pt": "Sidon"}
			]
		},
		{
			"question":
			{
				"en": "What mountain is traditionally associated with the Transfiguration?",
				"pt": "What mountain is traditionally associated with the Transfiguration?"
			},
			"answer": {"en": "Mount Tabor", "pt": "Mount Tabor"},
			"tier": 3,
			"decoys":
			[
				{"en": "Mount Hermon", "pt": "Mount Hermon"},
				{"en": "Mount Moriah", "pt": "Mount Moriah"},
				{"en": "Mount Zion", "pt": "Mount Zion"}
			]
		},
		{
			"question":
			{
				"en": "Which city sat on seven hills and ruled the empire in Paul's day?",
				"pt": "Which city sat on seven hills and ruled the empire in Paul's day?"
			},
			"answer": {"en": "Rome", "pt": "Rome"},
			"tier": 3,
			"decoys":
			[
				{"en": "Athens", "pt": "Athens"},
				{"en": "Corinth", "pt": "Corinth"},
				{"en": "Ephesus", "pt": "Ephesus"}
			]
		},
		{
			"question":
			{
				"en": "What ancient route east of the Jordan was called the King's Highway?",
				"pt": "What ancient route east of the Jordan was called the King's Highway?"
			},
			"answer": {"en": "The King's Highway", "pt": "The King's Highway"},
			"tier": 3,
			"decoys":
			[
				{"en": "Via Maris", "pt": "Via Maris"},
				{"en": "Road to Jericho", "pt": "Road to Jericho"},
				{"en": "Desert Way", "pt": "Desert Way"}
			]
		},
		{
			"question":
			{"en": "On which mountain did Aaron die?", "pt": "On which mountain did Aaron die?"},
			"answer": {"en": "Mount Hor", "pt": "Mount Hor"},
			"tier": 3,
			"decoys":
			[
				{"en": "Mount Nebo", "pt": "Mount Nebo"},
				{"en": "Mount Sinai", "pt": "Mount Sinai"},
				{"en": "Mount Carmel", "pt": "Mount Carmel"}
			]
		},
		{
			"question":
			{
				"en": "Which northern mountain is near the source of the Jordan River?",
				"pt": "Which northern mountain is near the source of the Jordan River?"
			},
			"answer": {"en": "Mount Hermon", "pt": "Mount Hermon"},
			"tier": 3,
			"decoys":
			[
				{"en": "Mount Ararat", "pt": "Mount Ararat"},
				{"en": "Mount Sinai", "pt": "Mount Sinai"},
				{"en": "Mount Tabor", "pt": "Mount Tabor"}
			]
		}
	],
	"Cities of the Bible":
	[
		{
			"question":
			{
				"en": "Which city did God send Jonah to warn?",
				"pt": "Qual cidade Deus enviou Jonas para avisar?"
			},
			"answer": {"en": "Nineveh", "pt": "Nínive"},
			"tier": 1,
			"decoys":
			[
				{"en": "Tarshish", "pt": "Társis"},
				{"en": "Damascus", "pt": "Damasco"},
				{"en": "Babylon", "pt": "Babilônia"}
			]
		},
		{
			"question":
			{
				"en": "Which city was famous for its walls rebuilt by Nehemiah?",
				"pt": "Qual cidade ficou famosa por suas muralhas reconstruídas por Neemias?"
			},
			"answer": {"en": "Jerusalem", "pt": "Jerusalém"},
			"tier": 1,
			"decoys":
			[
				{"en": "Babylon", "pt": "Babilônia"},
				{"en": "Tyre", "pt": "Pneu"},
				{"en": "Samaria", "pt": "Samaria"}
			]
		},
		{
			"question":
			{
				"en": "Which city was home to the queen Esther?",
				"pt": "Qual cidade foi o lar da rainha Ester?"
			},
			"answer": {"en": "Susa", "pt": "Susa"},
			"tier": 2,
			"decoys":
			[
				{"en": "Shushan", "pt": "Shushan"},
				{"en": "Persepolis", "pt": "Persépolis"},
				{"en": "Ecbatana", "pt": "Ecbátana"}
			]
		},
		{
			"question":
			{
				"en": "Which city saw Paul's riot over silversmiths?",
				"pt": "Qual cidade viu o motim de Paulo por causa dos ourives?"
			},
			"answer": {"en": "Ephesus", "pt": "Éfeso"},
			"tier": 2,
			"decoys":
			[
				{"en": "Corinth", "pt": "Corinto"},
				{"en": "Athens", "pt": "Atenas"},
				{"en": "Philippi", "pt": "Filipos"}
			]
		},
		{
			"question":
			{
				"en": "Which city did Jesus lament saying He would gather its children?",
				"pt": "Qual cidade Jesus lamentou dizendo que reuniria seus filhos?"
			},
			"answer": {"en": "Jerusalem", "pt": "Jerusalém"},
			"tier": 1,
			"decoys":
			[
				{"en": "Bethany", "pt": "Betânia"},
				{"en": "Nazareth", "pt": "Nazaré"},
				{"en": "Capernaum", "pt": "Cafarnaum"}
			]
		},
		{
			"question":
			{"en": "In which town did Jesus grow up?", "pt": "Em que cidade Jesus cresceu?"},
			"answer": {"en": "Nazareth", "pt": "Nazaré"},
			"tier": 1,
			"decoys":
			[
				{"en": "Bethlehem", "pt": "Belém"},
				{"en": "Capernaum", "pt": "Cafarnaum"},
				{"en": "Bethany", "pt": "Betânia"}
			]
		},
		{
			"question":
			{"en": "In which city was Jesus born?", "pt": "Em que cidade Jesus nasceu?"},
			"answer": {"en": "Bethlehem", "pt": "Belém"},
			"tier": 1,
			"decoys":
			[
				{"en": "Nazareth", "pt": "Nazaré"},
				{"en": "Jericho", "pt": "Jericó"},
				{"en": "Hebron", "pt": "Hebrom"}
			]
		},
		{
			"question":
			{
				"en": "Which city's walls fell after Israel marched and shouted?",
				"pt": "Os muros de qual cidade caíram depois que Israel marchou e gritou?"
			},
			"answer": {"en": "Jericho", "pt": "Jericó"},
			"tier": 1,
			"decoys":
			[
				{"en": "Ai", "pt": "Ai"},
				{"en": "Bethel", "pt": "Betel"},
				{"en": "Hazor", "pt": "Hazor"}
			]
		},
		{
			"question":
			{
				"en": "Where were believers first called Christians?",
				"pt": "Onde os crentes foram chamados de cristãos pela primeira vez?"
			},
			"answer": {"en": "Antioch", "pt": "Antioquia"},
			"tier": 2,
			"decoys":
			[
				{"en": "Jerusalem", "pt": "Jerusalém"},
				{"en": "Damascus", "pt": "Damasco"},
				{"en": "Philippi", "pt": "Filipos"}
			]
		},
		{
			"question":
			{
				"en": "In which city did Paul preach at the Areopagus?",
				"pt": "Em que cidade Paulo pregou no Areópago?"
			},
			"answer": {"en": "Athens", "pt": "Atenas"},
			"tier": 2,
			"decoys":
			[
				{"en": "Corinth", "pt": "Corinto"},
				{"en": "Ephesus", "pt": "Éfeso"},
				{"en": "Rome", "pt": "Roma"}
			]
		},
		{
			"question":
			{
				"en": "What city served as capital of the northern kingdom of Israel?",
				"pt": "Que cidade serviu como capital do reino do norte de Israel?"
			},
			"answer": {"en": "Samaria", "pt": "Samaria"},
			"tier": 2,
			"decoys":
			[
				{"en": "Jerusalem", "pt": "Jerusalém"},
				{"en": "Bethel", "pt": "Betel"},
				{"en": "Dan", "pt": "Dan"}
			]
		},
		{
			"question":
			{
				"en": "Which Greek city received Paul's letters about unity and spiritual gifts?",
				"pt":
				"Qual cidade grega recebeu as cartas de Paulo sobre unidade e dons espirituais?"
			},
			"answer": {"en": "Corinth", "pt": "Corinto"},
			"tier": 1,
			"decoys":
			[
				{"en": "Athens", "pt": "Atenas"},
				{"en": "Philippi", "pt": "Filipos"},
				{"en": "Rome", "pt": "Roma"}
			]
		},
		{
			"question":
			{
				"en": "Which Roman colony saw the conversion of a jailer and Lydia?",
				"pt": "Qual colônia romana viu a conversão de um carcereiro e de Lídia?"
			},
			"answer": {"en": "Philippi", "pt": "Filipos"},
			"tier": 2,
			"decoys":
			[
				{"en": "Thessalonica", "pt": "Tessalônica"},
				{"en": "Iconium", "pt": "Icônio"},
				{"en": "Derbe", "pt": "Derbe"}
			]
		},
		{
			"question":
			{
				"en": "Which port city hosted Peter's visit to Cornelius?",
				"pt": "Qual cidade portuária hospedou a visita de Pedro a Cornélio?"
			},
			"answer": {"en": "Caesarea", "pt": "Cesaréia"},
			"tier": 2,
			"decoys":
			[
				{"en": "Joppa", "pt": "Jope"},
				{"en": "Tyre", "pt": "Pneu"},
				{"en": "Sidon", "pt": "Sídon"}
			]
		},
		{
			"question":
			{
				"en": "Which Galilean town became Jesus' ministry base?",
				"pt": "Qual cidade da Galiléia se tornou a base do ministério de Jesus?"
			},
			"answer": {"en": "Capernaum", "pt": "Cafarnaum"},
			"tier": 1,
			"decoys":
			[
				{"en": "Bethsaida", "pt": "Betsaida"},
				{"en": "Nazareth", "pt": "Nazaré"},
				{"en": "Cana", "pt": "Caná"}
			]
		},
		{
			"question":
			{
				"en": "Where did Jesus turn water into wine?",
				"pt": "Onde Jesus transformou água em vinho?"
			},
			"answer": {"en": "Cana", "pt": "Caná"},
			"tier": 1,
			"decoys":
			[
				{"en": "Capernaum", "pt": "Cafarnaum"},
				{"en": "Nain", "pt": "Naim"},
				{"en": "Emmaus", "pt": "Emaús"}
			]
		},
		{
			"question":
			{
				"en": "On the way to which city was Saul confronted by Jesus?",
				"pt": "No caminho para qual cidade Saulo foi confrontado por Jesus?"
			},
			"answer": {"en": "Damascus", "pt": "Damasco"},
			"tier": 1,
			"decoys":
			[
				{"en": "Jerusalem", "pt": "Jerusalém"},
				{"en": "Jericho", "pt": "Jericó"},
				{"en": "Caesarea", "pt": "Cesaréia"}
			]
		},
		{
			"question":
			{
				"en": "Where was the ark of the covenant housed before the temple was built?",
				"pt": "Onde estava a arca da aliança antes da construção do templo?"
			},
			"answer": {"en": "Shiloh", "pt": "Siló"},
			"tier": 3,
			"decoys":
			[
				{"en": "Bethel", "pt": "Betel"},
				{"en": "Hebron", "pt": "Hebrom"},
				{"en": "Gibeah", "pt": "Gibeá"}
			]
		},
		{
			"question":
			{
				"en": "At which place did Jacob dream of a ladder to heaven?",
				"pt": "Em que lugar Jacó sonhou com uma escada para o céu?"
			},
			"answer": {"en": "Bethel", "pt": "Betel"},
			"tier": 2,
			"decoys":
			[
				{"en": "Beersheba", "pt": "Bersebá"},
				{"en": "Jericho", "pt": "Jericó"},
				{"en": "Dan", "pt": "Dan"}
			]
		},
		{
			"question":
			{
				"en": "From which city did David first rule before taking Jerusalem?",
				"pt": "De qual cidade Davi governou primeiro antes de tomar Jerusalém?"
			},
			"answer": {"en": "Hebron", "pt": "Hebrom"},
			"tier": 2,
			"decoys":
			[
				{"en": "Bethlehem", "pt": "Belém"},
				{"en": "Mahanaim", "pt": "Maanaim"},
				{"en": "Hazor", "pt": "Hazor"}
			]
		},
		{
			"question":
			{
				"en": "Which city was called the City of Palms?",
				"pt": "Which city was called the City of Palms?"
			},
			"answer": {"en": "Jericho", "pt": "Jericho"},
			"tier": 2,
			"decoys":
			[
				{"en": "Jerusalem", "pt": "Jerusalem"},
				{"en": "Bethlehem", "pt": "Bethlehem"},
				{"en": "Bethel", "pt": "Bethel"}
			]
		},
		{
			"question":
			{
				"en": "Which Red Sea port did Solomon use for trade to Ophir?",
				"pt": "Which Red Sea port did Solomon use for trade to Ophir?"
			},
			"answer": {"en": "Ezion-Geber", "pt": "Ezion-Geber"},
			"tier": 3,
			"decoys":
			[
				{"en": "Joppa", "pt": "Joppa"},
				{"en": "Tyre", "pt": "Tyre"},
				{"en": "Sidon", "pt": "Sidon"}
			]
		},
		{
			"question":
			{
				"en": "In which city was King Josiah killed in battle?",
				"pt": "In which city was King Josiah killed in battle?"
			},
			"answer": {"en": "Megiddo", "pt": "Megiddo"},
			"tier": 3,
			"decoys":
			[
				{"en": "Jerusalem", "pt": "Jerusalem"},
				{"en": "Bethel", "pt": "Bethel"},
				{"en": "Jericho", "pt": "Jericho"}
			]
		},
		{
			"question":
			{
				"en":
				"Where did Israel first camp after crossing the Jordan and set up twelve stones?",
				"pt":
				"Where did Israel first camp after crossing the Jordan and set up twelve stones?"
			},
			"answer": {"en": "Gilgal", "pt": "Gilgal"},
			"tier": 3,
			"decoys":
			[
				{"en": "Shiloh", "pt": "Shiloh"},
				{"en": "Bethel", "pt": "Bethel"},
				{"en": "Shechem", "pt": "Shechem"}
			]
		},
		{
			"question":
			{
				"en": "Which coastal city was seat of Roman governors in Judea?",
				"pt": "Which coastal city was seat of Roman governors in Judea?"
			},
			"answer": {"en": "Caesarea Maritima", "pt": "Caesarea Maritima"},
			"tier": 3,
			"decoys":
			[
				{"en": "Joppa", "pt": "Joppa"},
				{"en": "Gaza", "pt": "Gaza"},
				{"en": "Ptolemais", "pt": "Ptolemais"}
			]
		},
		{
			"question":
			{
				"en": "Which city was famously built on seven hills and ruled the world empire?",
				"pt": "Which city was famously built on seven hills and ruled the world empire?"
			},
			"answer": {"en": "Rome", "pt": "Rome"},
			"tier": 3,
			"decoys":
			[
				{"en": "Athens", "pt": "Athens"},
				{"en": "Alexandria", "pt": "Alexandria"},
				{"en": "Ephesus", "pt": "Ephesus"}
			]
		},
		{
			"question":
			{
				"en": "Which city was known for lukewarm water between hot and cold springs?",
				"pt": "Which city was known for lukewarm water between hot and cold springs?"
			},
			"answer": {"en": "Laodicea", "pt": "Laodicea"},
			"tier": 3,
			"decoys":
			[
				{"en": "Colossae", "pt": "Colossae"},
				{"en": "Hierapolis", "pt": "Hierapolis"},
				{"en": "Pergamum", "pt": "Pergamum"}
			]
		},
		{
			"question":
			{
				"en": "Which city housed the massive Temple of Artemis?",
				"pt": "Which city housed the massive Temple of Artemis?"
			},
			"answer": {"en": "Ephesus", "pt": "Ephesus"},
			"tier": 3,
			"decoys":
			[
				{"en": "Corinth", "pt": "Corinth"},
				{"en": "Athens", "pt": "Athens"},
				{"en": "Rome", "pt": "Rome"}
			]
		},
		{
			"question":
			{
				"en": "Which city served as the missionary hub sending Paul and Barnabas?",
				"pt": "Which city served as the missionary hub sending Paul and Barnabas?"
			},
			"answer": {"en": "Antioch of Syria", "pt": "Antioch of Syria"},
			"tier": 3,
			"decoys":
			[
				{"en": "Jerusalem", "pt": "Jerusalem"},
				{"en": "Damascus", "pt": "Damascus"},
				{"en": "Philippi", "pt": "Philippi"}
			]
		},
		{
			"question":
			{
				"en": "Which rock-carved capital of Edom was also called Sela?",
				"pt": "Which rock-carved capital of Edom was also called Sela?"
			},
			"answer": {"en": "Petra", "pt": "Petra"},
			"tier": 3,
			"decoys":
			[
				{"en": "Samaria", "pt": "Samaria"},
				{"en": "Nineveh", "pt": "Nineveh"},
				{"en": "Rabbah", "pt": "Rabbah"}
			]
		}
	],
	"Animals in the Bible":
	[
		{
			"question":
			{
				"en": "What animal spoke to Balaam on the road?",
				"pt": "Que animal falou com Balaão na estrada?"
			},
			"answer": {"en": "A donkey", "pt": "Um burro"},
			"tier": 1,
			"decoys":
			[
				{"en": "A lion", "pt": "Um leão"},
				{"en": "A goat", "pt": "Uma cabra"},
				{"en": "A raven", "pt": "Um corvo"}
			]
		},
		{
			"question":
			{
				"en": "What animals fed Elijah at the brook Cherith?",
				"pt": "Que animais alimentaram Elias no riacho Querite?"
			},
			"answer": {"en": "Ravens", "pt": "Corvos"},
			"tier": 1,
			"decoys":
			[
				{"en": "Doves", "pt": "Pombas"},
				{"en": "Quail", "pt": "Codorniz"},
				{"en": "Sheep", "pt": "Ovelha"}
			]
		},
		{
			"question":
			{
				"en": "What animal pulled the ark cart back to Israel in 1 Samuel 6?",
				"pt": "Que animal puxou a arca de volta para Israel em 1 Samuel 6?"
			},
			"answer": {"en": "Cows", "pt": "Vacas"},
			"tier": 2,
			"decoys":
			[
				{"en": "Donkeys", "pt": "Burros"},
				{"en": "Oxen", "pt": "Bois"},
				{"en": "Camels", "pt": "Camelos"}
			]
		},
		{
			"question":
			{
				"en": "Which animal is compared to believers in Psalm 23?",
				"pt": "Qual animal é comparado aos crentes no Salmo 23?"
			},
			"answer": {"en": "Sheep", "pt": "Ovelha"},
			"tier": 1,
			"decoys":
			[
				{"en": "Goats", "pt": "Cabras"},
				{"en": "Cattle", "pt": "Gado"},
				{"en": "Doves", "pt": "Pombas"}
			]
		},
		{
			"question":
			{"en": "What creature swallowed Jonah?", "pt": "Que criatura engoliu Jonas?"},
			"answer": {"en": "A great fish", "pt": "Um ótimo peixe"},
			"tier": 1,
			"decoys":
			[
				{"en": "A whale", "pt": "Uma baleia"},
				{"en": "A sea serpent", "pt": "Uma serpente marinha"},
				{"en": "A shark", "pt": "Um tubarão"}
			]
		},
		{
			"question":
			{
				"en": "What bird did Noah send out to see if the waters had receded?",
				"pt": "Que pássaro Noé enviou para ver se as águas haviam baixado?"
			},
			"answer": {"en": "A dove", "pt": "Uma pomba"},
			"tier": 1,
			"decoys":
			[
				{"en": "A raven", "pt": "Um corvo"},
				{"en": "An eagle", "pt": "Uma águia"},
				{"en": "A sparrow", "pt": "Um pardal"}
			]
		},
		{
			"question":
			{
				"en":
				"What animals did Samson tie together with torches to burn Philistine fields?",
				"pt": "Que animais Sansão amarrou com tochas para queimar os campos dos filisteus?"
			},
			"answer": {"en": "Foxes", "pt": "Raposas"},
			"tier": 2,
			"decoys":
			[
				{"en": "Wolves", "pt": "Lobos"},
				{"en": "Goats", "pt": "Cabras"},
				{"en": "Bulls", "pt": "Touros"}
			]
		},
		{
			"question":
			{
				"en": "What animal carried Jesus into Jerusalem?",
				"pt": "Que animal levou Jesus para Jerusalém?"
			},
			"answer": {"en": "A young donkey", "pt": "Um jovem burro"},
			"tier": 1,
			"decoys":
			[
				{"en": "A camel", "pt": "Um camelo"},
				{"en": "A horse", "pt": "Um cavalo"},
				{"en": "An ox", "pt": "Um boi"}
			]
		},
		{
			"question":
			{
				"en": "What animal appeared in the thicket as a substitute for Isaac?",
				"pt": "Que animal apareceu no matagal como substituto de Isaque?"
			},
			"answer": {"en": "A ram", "pt": "Um carneiro"},
			"tier": 3,
			"decoys":
			[
				{"en": "A goat", "pt": "Uma cabra"},
				{"en": "A bull", "pt": "Um touro"},
				{"en": "A calf", "pt": "Um bezerro"}
			]
		},
		{
			"question":
			{
				"en": "What animal bit Paul on Malta without harming him?",
				"pt": "Que animal mordeu Paulo em Malta sem machucá-lo?"
			},
			"answer": {"en": "A viper", "pt": "Uma víbora"},
			"tier": 2,
			"decoys":
			[
				{"en": "A scorpion", "pt": "Um escorpião"},
				{"en": "A locust", "pt": "Um gafanhoto"},
				{"en": "A spider", "pt": "Uma aranha"}
			]
		},
		{
			"question":
			{
				"en": "What birds supplied meat to Israel in the wilderness?",
				"pt": "Que aves forneciam carne a Israel no deserto?"
			},
			"answer": {"en": "Quail", "pt": "Codorniz"},
			"tier": 1,
			"decoys":
			[
				{"en": "Doves", "pt": "Pombas"},
				{"en": "Pigeons", "pt": "Pombos"},
				{"en": "Hawks", "pt": "Falcões"}
			]
		},
		{
			"question":
			{
				"en": "What tool did Samson use to strike the Philistines?",
				"pt": "Que ferramenta Sansão usou para atacar os filisteus?"
			},
			"answer": {"en": "A donkey's jawbone", "pt": "A mandíbula de um burro"},
			"tier": 2,
			"decoys":
			[
				{"en": "An ox goad", "pt": "Um aguilhão de boi"},
				{"en": "A spear", "pt": "Uma lança"},
				{"en": "A plow handle", "pt": "Um cabo de arado"}
			]
		},
		{
			"question":
			{
				"en": "What animals mauled youths who mocked Elisha?",
				"pt": "Que animais atacaram os jovens que zombaram de Eliseu?"
			},
			"answer": {"en": "Bears", "pt": "Ursos"},
			"tier": 2,
			"decoys":
			[
				{"en": "Lions", "pt": "Leões"},
				{"en": "Leopards", "pt": "Leopardos"},
				{"en": "Hyenas", "pt": "Hienas"}
			]
		},
		{
			"question":
			{
				"en": "What bird's crow reminded Peter of his denial?",
				"pt": "Que pássaro corvo lembrou Pedro de sua negação?"
			},
			"answer": {"en": "A rooster", "pt": "Um galo"},
			"tier": 1,
			"decoys":
			[
				{"en": "A dog", "pt": "Um cachorro"},
				{"en": "A fox", "pt": "Uma raposa"},
				{"en": "A lamb", "pt": "Um cordeiro"}
			]
		},
		{
			"question":
			{
				"en": "What animals did Rebekah water for Abraham's servant?",
				"pt": "Que animais Rebeca deu água ao servo de Abraão?"
			},
			"answer": {"en": "Camels", "pt": "Camelos"},
			"tier": 1,
			"decoys":
			[
				{"en": "Donkeys", "pt": "Burros"},
				{"en": "Cattle", "pt": "Gado"},
				{"en": "Goats", "pt": "Cabras"}
			]
		},
		{
			"question":
			{
				"en": "Which insects were a devastating plague in Egypt?",
				"pt": "Quais insetos foram uma praga devastadora no Egito?"
			},
			"answer": {"en": "Locusts", "pt": "Gafanhotos"},
			"tier": 1,
			"decoys":
			[
				{"en": "Frogs", "pt": "Sapos"},
				{"en": "Flies", "pt": "Moscas"},
				{"en": "Gnats", "pt": "mosquitos"}
			]
		},
		{
			"question":
			{
				"en": "What creature did Moses lift on a pole for healing in the wilderness?",
				"pt": "Que criatura Moisés ergueu num poste para ser curada no deserto?"
			},
			"answer": {"en": "A bronze serpent", "pt": "Uma serpente de bronze"},
			"tier": 2,
			"decoys":
			[
				{"en": "A bronze lion", "pt": "Um leão de bronze"},
				{"en": "A golden calf", "pt": "Um bezerro de ouro"},
				{"en": "A wooden dove", "pt": "Uma pomba de madeira"}
			]
		},
		{
			"question":
			{
				"en": "What animals are separated in Jesus' teaching about final judgment?",
				"pt": "Que animais são separados no ensino de Jesus sobre o julgamento final?"
			},
			"answer": {"en": "Sheep and goats", "pt": "Ovelhas e cabras"},
			"tier": 3,
			"decoys":
			[
				{"en": "A shepherd and wolves", "pt": "Um pastor e lobos"},
				{
					"en": "The good Samaritan and the injured man",
					"pt": "O bom samaritano e o homem ferido"
				},
				{"en": "A dragnet of fish", "pt": "Uma rede de peixes"}
			]
		},
		{
			"question":
			{
				"en": "What animal image describes Jesus led silently to death?",
				"pt": "Que imagem animal descreve Jesus levado silenciosamente à morte?"
			},
			"answer": {"en": "A lamb", "pt": "Um cordeiro"},
			"tier": 2,
			"decoys":
			[
				{"en": "A goat", "pt": "Uma cabra"},
				{"en": "A bull", "pt": "Um touro"},
				{"en": "A ram", "pt": "Um carneiro"}
			]
		},
		{
			"question":
			{
				"en": "What animal was released into the wilderness on the Day of Atonement?",
				"pt": "Que animal foi solto no deserto no Dia da Expiação?"
			},
			"answer": {"en": "A scapegoat", "pt": "Um bode expiatório"},
			"tier": 3,
			"decoys":
			[
				{"en": "A burnt offering bull", "pt": "Um touro de oferta queimada"},
				{"en": "A golden calf", "pt": "Um bezerro de ouro"},
				{"en": "The Passover lamb", "pt": "O cordeiro pascal"}
			]
		},
		{
			"question":
			{
				"en": "What animal did the father of the prodigal son order to be killed?",
				"pt": "What animal did the father of the prodigal son order to be killed?"
			},
			"answer": {"en": "The fattened calf", "pt": "The fattened calf"},
			"tier": 2,
			"decoys":
			[
				{"en": "A ram", "pt": "A ram"},
				{"en": "A goat", "pt": "A goat"},
				{"en": "A dove", "pt": "A dove"}
			]
		},
		{
			"question":
			{"en": "What animal did Jesus call Herod?", "pt": "What animal did Jesus call Herod?"},
			"answer": {"en": "A fox", "pt": "A fox"},
			"tier": 2,
			"decoys":
			[
				{"en": "A wolf", "pt": "A wolf"},
				{"en": "A serpent", "pt": "A serpent"},
				{"en": "A viper", "pt": "A viper"}
			]
		},
		{
			"question":
			{
				"en": "What animals did Jesus warn of in sheep's clothing?",
				"pt": "What animals did Jesus warn of in sheep's clothing?"
			},
			"answer": {"en": "Wolves", "pt": "Wolves"},
			"tier": 2,
			"decoys":
			[
				{"en": "Bears", "pt": "Bears"},
				{"en": "Foxes", "pt": "Foxes"},
				{"en": "Lions", "pt": "Lions"}
			]
		},
		{
			"question":
			{
				"en": "Which small animal makes its home in the crags and is called wise?",
				"pt": "Which small animal makes its home in the crags and is called wise?"
			},
			"answer": {"en": "The rock badger (hyrax)", "pt": "The rock badger (hyrax)"},
			"tier": 3,
			"decoys":
			[
				{"en": "The fox", "pt": "The fox"},
				{"en": "The otter", "pt": "The otter"},
				{"en": "The weasel", "pt": "The weasel"}
			]
		},
		{
			"question":
			{
				"en": "Which small creature marches in ranks without a king?",
				"pt": "Which small creature marches in ranks without a king?"
			},
			"answer": {"en": "Locusts", "pt": "Locusts"},
			"tier": 3,
			"decoys":
			[
				{"en": "Ants", "pt": "Ants"},
				{"en": "Mice", "pt": "Mice"},
				{"en": "Sparrows", "pt": "Sparrows"}
			]
		},
		{
			"question":
			{
				"en":
				"Which small creature can be caught with the hands yet lives in kings' palaces?",
				"pt":
				"Which small creature can be caught with the hands yet lives in kings' palaces?"
			},
			"answer": {"en": "A lizard", "pt": "A lizard"},
			"tier": 3,
			"decoys":
			[
				{"en": "A mouse", "pt": "A mouse"},
				{"en": "A sparrow", "pt": "A sparrow"},
				{"en": "A mole", "pt": "A mole"}
			]
		},
		{
			"question":
			{
				"en": "Which animal in Daniel's vision represented Greece?",
				"pt": "Which animal in Daniel's vision represented Greece?"
			},
			"answer": {"en": "A male goat", "pt": "A male goat"},
			"tier": 3,
			"decoys":
			[
				{"en": "A bear", "pt": "A bear"},
				{"en": "A leopard", "pt": "A leopard"},
				{"en": "A ram", "pt": "A ram"}
			]
		},
		{
			"question":
			{
				"en": "Which creature in Revelation 12 symbolized Satan?",
				"pt": "Which creature in Revelation 12 symbolized Satan?"
			},
			"answer": {"en": "A great red dragon", "pt": "A great red dragon"},
			"tier": 3,
			"decoys":
			[
				{"en": "A sea serpent", "pt": "A sea serpent"},
				{"en": "A leopard beast", "pt": "A leopard beast"},
				{"en": "A pale horse", "pt": "A pale horse"}
			]
		},
		{
			"question":
			{
				"en": "Which animal killed the disobedient prophet in 1 Kings 13?",
				"pt": "Which animal killed the disobedient prophet in 1 Kings 13?"
			},
			"answer": {"en": "A lion", "pt": "A lion"},
			"tier": 3,
			"decoys":
			[
				{"en": "A bear", "pt": "A bear"},
				{"en": "A wolf", "pt": "A wolf"},
				{"en": "A dog", "pt": "A dog"}
			]
		},
		{
			"question":
			{
				"en": "Which tribe was compared to a ravenous wolf in Jacob's blessing?",
				"pt": "Which tribe was compared to a ravenous wolf in Jacob's blessing?"
			},
			"answer": {"en": "Benjamin", "pt": "Benjamin"},
			"tier": 3,
			"decoys":
			[
				{"en": "Judah", "pt": "Judah"},
				{"en": "Levi", "pt": "Levi"},
				{"en": "Issachar", "pt": "Issachar"}
			]
		}
	],
	"Dreams & Visions":
	[
		{
			"question":
			{
				"en": "Who interpreted Pharaoh's dreams of cows and grain?",
				"pt": "Quem interpretou os sonhos do Faraó sobre vacas e grãos?"
			},
			"answer": {"en": "Joseph", "pt": "José"},
			"tier": 1,
			"decoys":
			[
				{"en": "Daniel", "pt": "Danilo"},
				{"en": "Moses", "pt": "Moisés"},
				{"en": "Pharaoh's magicians", "pt": "Os mágicos do Faraó"}
			]
		},
		{
			"question":
			{
				"en": "Who saw a ladder reaching to heaven at Bethel?",
				"pt": "Quem viu uma escada chegando ao céu em Betel?"
			},
			"answer": {"en": "Jacob", "pt": "Jacó"},
			"tier": 1,
			"decoys":
			[
				{"en": "Abraham", "pt": "Abraão"},
				{"en": "Isaac", "pt": "Isaque"},
				{"en": "Joseph", "pt": "José"}
			]
		},
		{
			"question":
			{
				"en": "Which king dreamed of a great statue shattered by a stone?",
				"pt": "Qual rei sonhou com uma grande estátua destruída por uma pedra?"
			},
			"answer": {"en": "Nebuchadnezzar", "pt": "Nabucodonosor"},
			"tier": 2,
			"decoys":
			[
				{"en": "Darius", "pt": "Dario"},
				{"en": "Belshazzar", "pt": "Belsazar"},
				{"en": "Cyrus", "pt": "Ciro"}
			]
		},
		{
			"question":
			{
				"en": "Who saw unclean animals lowered on a sheet in a vision?",
				"pt": "Quem viu animais impuros baixados sobre um lençol em uma visão?"
			},
			"answer": {"en": "Peter", "pt": "Peter"},
			"tier": 1,
			"decoys":
			[
				{"en": "Paul", "pt": "Paulo"},
				{"en": "John", "pt": "John"},
				{"en": "Philip", "pt": "Filipe"}
			]
		},
		{
			"question":
			{
				"en": "Who saw the Lord high and lifted up with seraphim?",
				"pt": "Quem viu o Senhor elevado e exaltado com serafins?"
			},
			"answer": {"en": "Isaiah", "pt": "Isaías"},
			"tier": 2,
			"decoys":
			[
				{"en": "Ezekiel", "pt": "Ezequiel"},
				{"en": "Daniel", "pt": "Danilo"},
				{"en": "Jeremiah", "pt": "Jeremias"}
			]
		},
		{
			"question":
			{
				"en":
				"Who dreamed his brothers' sheaves and the sun, moon, and stars bowed to him?",
				"pt":
				"Quem sonhou que os feixes de seus irmãos e o sol, a lua e as estrelas se curvassem diante dele?"
			},
			"answer": {"en": "Joseph", "pt": "José"},
			"tier": 1,
			"decoys":
			[
				{"en": "Pharaoh", "pt": "faraó"},
				{"en": "Nebuchadnezzar", "pt": "Nabucodonosor"},
				{"en": "Laban", "pt": "Labão"}
			]
		},
		{
			"question":
			{
				"en": "Who dreamed an angel telling him not to fear taking Mary as his wife?",
				"pt": "Quem sonhou com um anjo lhe dizendo para não temer tomar Maria como esposa?"
			},
			"answer": {"en": "Joseph, husband of Mary", "pt": "José, marido de Maria"},
			"tier": 1,
			"decoys":
			[
				{"en": "Zechariah", "pt": "Zacarias"},
				{"en": "Simeon", "pt": "Simeão"},
				{"en": "Nicodemus", "pt": "Nicodemos"}
			]
		},
		{
			"question":
			{
				"en": "Who was warned in a dream to flee to Egypt with Mary and Jesus?",
				"pt": "Quem foi avisado em sonho para fugir para o Egito com Maria e Jesus?"
			},
			"answer": {"en": "Joseph, husband of Mary", "pt": "José, marido de Maria"},
			"tier": 1,
			"decoys":
			[
				{"en": "Herod", "pt": "Herodes"},
				{"en": "Peter", "pt": "Peter"},
				{"en": "John the Baptist", "pt": "João Batista"}
			]
		},
		{
			"question":
			{
				"en": "Who was told in a dream to return from Egypt and settle in Galilee?",
				"pt":
				"A quem foi dito em sonho que voltasse do Egito e se estabelecesse na Galiléia?"
			},
			"answer": {"en": "Joseph, husband of Mary", "pt": "José, marido de Maria"},
			"tier": 2,
			"decoys":
			[
				{"en": "Mary", "pt": "Mary"},
				{"en": "Elizabeth", "pt": "Elisabete"},
				{"en": "Joseph of Arimathea", "pt": "José de Arimatéia"}
			]
		},
		{
			"question":
			{
				"en": "Who saw a man of Macedonia begging him to come and help?",
				"pt": "Quem viu um homem da Macedônia implorando para que ele viesse ajudar?"
			},
			"answer": {"en": "Paul", "pt": "Paulo"},
			"tier": 2,
			"decoys":
			[
				{"en": "A Roman soldier", "pt": "Um soldado romano"},
				{"en": "A Samaritan woman", "pt": "Uma mulher samaritana"},
				{"en": "A priest from Jericho", "pt": "Um sacerdote de Jericó"}
			]
		},
		{
			"question":
			{
				"en":
				"Who appeared to Paul in a night vision saying, 'Do not be afraid; keep on speaking'?",
				"pt":
				"Que apareceu a Paulo numa visão noturna dizendo: 'Não tenha medo; continue falando'?"
			},
			"answer": {"en": "The Lord Jesus", "pt": "O Senhor Jesus"},
			"tier": 3,
			"decoys":
			[
				{"en": "Barnabas", "pt": "Barnabé"},
				{"en": "Silas", "pt": "Silas"},
				{"en": "An unnamed angel", "pt": "Um anjo sem nome"}
			]
		},
		{
			"question":
			{
				"en": "Whose dream warned her husband Pilate about Jesus?",
				"pt": "O sonho de quem alertou seu marido Pilatos sobre Jesus?"
			},
			"answer": {"en": "Pilate's wife", "pt": "A esposa de Pilatos"},
			"tier": 1,
			"decoys":
			[
				{"en": "Herodias", "pt": "Herodíade"},
				{"en": "Martha", "pt": "Marta"},
				{"en": "Priscilla", "pt": "Priscila"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet saw four great beasts rising from the sea?",
				"pt": "Qual profeta viu quatro grandes bestas surgindo do mar?"
			},
			"answer": {"en": "Daniel", "pt": "Danilo"},
			"tier": 2,
			"decoys":
			[
				{"en": "Nebuchadnezzar", "pt": "Nabucodonosor"},
				{"en": "Isaiah", "pt": "Isaías"},
				{"en": "Peter", "pt": "Peter"}
			]
		},
		{
			"question":
			{
				"en": "Which king dreamed of a vast tree that was cut down and bound with iron?",
				"pt": "Qual rei sonhou com uma enorme árvore que foi cortada e amarrada com ferro?"
			},
			"answer": {"en": "Nebuchadnezzar", "pt": "Nabucodonosor"},
			"tier": 2,
			"decoys":
			[
				{"en": "Darius", "pt": "Dario"},
				{"en": "Cyrus", "pt": "Ciro"},
				{"en": "Belshazzar", "pt": "Belsazar"}
			]
		},
		{
			"question":
			{
				"en": "Who saw a ram and a goat colliding in a vision explaining future kingdoms?",
				"pt":
				"Quem viu um carneiro e um bode colidindo numa visão explicando reinos futuros?"
			},
			"answer": {"en": "Daniel", "pt": "Danilo"},
			"tier": 3,
			"decoys":
			[
				{"en": "Ezekiel", "pt": "Ezequiel"},
				{"en": "Peter", "pt": "Peter"},
				{"en": "John", "pt": "John"}
			]
		},
		{
			"question":
			{
				"en": "Who saw the risen Christ walking among seven golden lampstands?",
				"pt": "Quem viu o Cristo ressuscitado andando entre sete candelabros de ouro?"
			},
			"answer": {"en": "John", "pt": "John"},
			"tier": 2,
			"decoys":
			[
				{"en": "Moses", "pt": "Moisés"},
				{"en": "Ezekiel", "pt": "Ezequiel"},
				{"en": "Samuel", "pt": "Samuel"}
			]
		},
		{
			"question":
			{
				"en": "Whose eyes were opened to see horses and chariots of fire on the hills?",
				"pt":
				"De quem foram os olhos abertos para ver cavalos e carros de fogo nas colinas?"
			},
			"answer": {"en": "Elisha's servant", "pt": "Servo de Eliseu"},
			"tier": 2,
			"decoys":
			[
				{"en": "Joshua", "pt": "Josué"},
				{"en": "Moses", "pt": "Moisés"},
				{"en": "Gideon", "pt": "Gideão"}
			]
		},
		{
			"question":
			{
				"en": "Who saw an angel in a vision instructing him to send for Peter from Joppa?",
				"pt": "Quem viu um anjo numa visão instruindo-o a mandar buscar Pedro em Jope?"
			},
			"answer": {"en": "Cornelius", "pt": "Cornélio"},
			"tier": 2,
			"decoys":
			[
				{"en": "Pilate", "pt": "Pilatos"},
				{"en": "Felix", "pt": "Félix"},
				{"en": "Festus", "pt": "Festo"}
			]
		},
		{
			"question":
			{
				"en": "Who saw in a vision that Saul of Tarsus would come and regain his sight?",
				"pt": "Quem viu numa visão que Saulo de Tarso viria e recuperaria a visão?"
			},
			"answer": {"en": "Ananias of Damascus", "pt": "Ananias de Damasco"},
			"tier": 2,
			"decoys":
			[
				{"en": "Philip", "pt": "Filipe"},
				{"en": "Cornelius", "pt": "Cornélio"},
				{"en": "Gamaliel", "pt": "Gamaliel"}
			]
		},
		{
			"question":
			{
				"en": "Who saw a bright light from heaven and heard Jesus on the road to Damascus?",
				"pt":
				"Quem viu uma luz brilhante vinda do céu e ouviu Jesus no caminho para Damasco?"
			},
			"answer": {"en": "Saul/Paul", "pt": "Saulo/Paulo"},
			"tier": 1,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "John Mark", "pt": "João Marcos"},
				{"en": "Luke", "pt": "Lucas"}
			]
		},
		{
			"question":
			{
				"en": "Who dreamed of three baskets of bread being eaten by birds?",
				"pt": "Who dreamed of three baskets of bread being eaten by birds?"
			},
			"answer": {"en": "Pharaoh's baker", "pt": "Pharaoh's baker"},
			"tier": 1,
			"decoys":
			[
				{"en": "Pharaoh's cupbearer", "pt": "Pharaoh's cupbearer"},
				{"en": "Joseph", "pt": "Joseph"},
				{"en": "Potiphar", "pt": "Potiphar"}
			]
		},
		{
			"question":
			{
				"en": "Who was warned in a dream not to return to Herod?",
				"pt": "Who was warned in a dream not to return to Herod?"
			},
			"answer": {"en": "The magi", "pt": "The magi"},
			"tier": 1,
			"decoys":
			[
				{"en": "The shepherds", "pt": "The shepherds"},
				{"en": "Zechariah", "pt": "Zechariah"},
				{"en": "Simeon", "pt": "Simeon"}
			]
		},
		{
			"question":
			{
				"en": "Who saw a man with a measuring line for Jerusalem?",
				"pt": "Who saw a man with a measuring line for Jerusalem?"
			},
			"answer": {"en": "Zechariah", "pt": "Zechariah"},
			"tier": 3,
			"decoys":
			[
				{"en": "Ezekiel", "pt": "Ezekiel"},
				{"en": "Isaiah", "pt": "Isaiah"},
				{"en": "Daniel", "pt": "Daniel"}
			]
		},
		{
			"question":
			{
				"en": "Who saw four horns and four craftsmen?",
				"pt": "Who saw four horns and four craftsmen?"
			},
			"answer": {"en": "Zechariah", "pt": "Zechariah"},
			"tier": 3,
			"decoys":
			[
				{"en": "Jeremiah", "pt": "Jeremiah"},
				{"en": "Haggai", "pt": "Haggai"},
				{"en": "Malachi", "pt": "Malachi"}
			]
		},
		{
			"question":
			{
				"en": "Who saw a flying scroll in a vision?",
				"pt": "Who saw a flying scroll in a vision?"
			},
			"answer": {"en": "Zechariah", "pt": "Zechariah"},
			"tier": 3,
			"decoys":
			[
				{"en": "Ezekiel", "pt": "Ezekiel"},
				{"en": "Daniel", "pt": "Daniel"},
				{"en": "John", "pt": "John"}
			]
		},
		{
			"question":
			{
				"en": "Who saw a woman in a basket carried by storks?",
				"pt": "Who saw a woman in a basket carried by storks?"
			},
			"answer": {"en": "Zechariah", "pt": "Zechariah"},
			"tier": 3,
			"decoys":
			[
				{"en": "Jeremiah", "pt": "Jeremiah"},
				{"en": "Habakkuk", "pt": "Habakkuk"},
				{"en": "Micah", "pt": "Micah"}
			]
		},
		{
			"question":
			{
				"en": "Who saw a golden lampstand with two olive trees beside it?",
				"pt": "Who saw a golden lampstand with two olive trees beside it?"
			},
			"answer": {"en": "Zechariah", "pt": "Zechariah"},
			"tier": 3,
			"decoys":
			[
				{"en": "John", "pt": "John"},
				{"en": "Ezekiel", "pt": "Ezekiel"},
				{"en": "Daniel", "pt": "Daniel"}
			]
		},
		{
			"question":
			{
				"en": "Who saw a valley of dry bones come to life?",
				"pt": "Who saw a valley of dry bones come to life?"
			},
			"answer": {"en": "Ezekiel", "pt": "Ezekiel"},
			"tier": 3,
			"decoys":
			[
				{"en": "Elijah", "pt": "Elijah"},
				{"en": "Daniel", "pt": "Daniel"},
				{"en": "Isaiah", "pt": "Isaiah"}
			]
		},
		{
			"question":
			{
				"en": "Who saw a river flowing from the temple bringing life?",
				"pt": "Who saw a river flowing from the temple bringing life?"
			},
			"answer": {"en": "Ezekiel", "pt": "Ezekiel"},
			"tier": 3,
			"decoys":
			[
				{"en": "Zechariah", "pt": "Zechariah"},
				{"en": "John", "pt": "John"},
				{"en": "Joel", "pt": "Joel"}
			]
		},
		{
			"question":
			{
				"en": "Who saw four living creatures and wheels full of eyes?",
				"pt": "Who saw four living creatures and wheels full of eyes?"
			},
			"answer": {"en": "Ezekiel", "pt": "Ezekiel"},
			"tier": 3,
			"decoys":
			[
				{"en": "Daniel", "pt": "Daniel"},
				{"en": "Jeremiah", "pt": "Jeremiah"},
				{"en": "Hosea", "pt": "Hosea"}
			]
		}
	],
	"Faith & Trust Stories":
	[
		{
			"question":
			{
				"en": "Who walked into the fiery furnace yet was unharmed?",
				"pt": "Quem entrou na fornalha ardente e saiu ileso?"
			},
			"answer":
			{"en": "Shadrach, Meshach, and Abednego", "pt": "Sadraque, Mesaque e Abednego"},
			"tier": 1,
			"decoys":
			[
				{"en": "Daniel and friends", "pt": "Daniel e amigos"},
				{"en": "Moses and Aaron", "pt": "Moisés e Aarão"},
				{"en": "Peter and John", "pt": "Pedro e João"}
			]
		},
		{
			"question":
			{
				"en": "Who faced a den of lions for praying to God?",
				"pt": "Quem enfrentou uma cova de leões por orar a Deus?"
			},
			"answer": {"en": "Daniel", "pt": "Danilo"},
			"tier": 1,
			"decoys":
			[
				{"en": "Joseph", "pt": "José"},
				{"en": "Nehemiah", "pt": "Neemias"},
				{"en": "Ezra", "pt": "Esdras"}
			]
		},
		{
			"question":
			{
				"en": "Who trusted God and climbed Mount Moriah with his son?",
				"pt": "Quem confiou em Deus e subiu o Monte Moriá com seu filho?"
			},
			"answer": {"en": "Abraham", "pt": "Abraão"},
			"tier": 1,
			"decoys":
			[
				{"en": "Jacob", "pt": "Jacó"},
				{"en": "Isaac", "pt": "Isaque"},
				{"en": "Job", "pt": "Trabalho"}
			]
		},
		{
			"question":
			{
				"en": "Who stepped into the flooded Jordan carrying the ark?",
				"pt": "Quem entrou no Jordão inundado carregando a arca?"
			},
			"answer": {"en": "The priests", "pt": "Os sacerdotes"},
			"tier": 2,
			"decoys":
			[
				{"en": "The Levite singers", "pt": "Os cantores levitas"},
				{"en": "The elders of Israel", "pt": "Os anciãos de Israel"},
				{"en": "Joshua and Caleb", "pt": "Josué e Calebe"}
			]
		},
		{
			"question":
			{
				"en": "Who said 'Though he slay me, yet will I trust him'?",
				"pt": "Quem disse: 'Embora ele me mate, confiarei nele'?"
			},
			"answer": {"en": "Job", "pt": "Trabalho"},
			"tier": 2,
			"decoys":
			[
				{"en": "David", "pt": "Davi"},
				{"en": "Habakkuk", "pt": "Habacuque"},
				{"en": "Paul", "pt": "Paulo"}
			]
		},
		{
			"question":
			{
				"en": "Who laid out a fleece twice to confirm God's call?",
				"pt": "Quem estendeu o velo duas vezes para confirmar o chamado de Deus?"
			},
			"answer": {"en": "Gideon", "pt": "Gideão"},
			"tier": 1,
			"decoys":
			[
				{"en": "Barak", "pt": "Baraque"},
				{"en": "Samson", "pt": "Sansão"},
				{"en": "Jephthah", "pt": "Jefté"}
			]
		},
		{
			"question":
			{
				"en": "Who clung to her mother-in-law saying 'Your people will be my people'?",
				"pt": "Quem se agarrou à sogra dizendo 'Seu povo será meu povo'?"
			},
			"answer": {"en": "Ruth", "pt": "Rute"},
			"tier": 1,
			"decoys":
			[
				{"en": "Orpah", "pt": "Orfa"},
				{"en": "Martha", "pt": "Marta"},
				{"en": "Esther", "pt": "Ester"}
			]
		},
		{
			"question":
			{
				"en": "Who built an ark in faithful obedience before rain ever fell?",
				"pt": "Quem construiu uma arca em fiel obediência antes mesmo de a chuva cair?"
			},
			"answer": {"en": "Noah", "pt": "Noé"},
			"tier": 1,
			"decoys":
			[
				{"en": "Moses", "pt": "Moisés"},
				{"en": "David", "pt": "Davi"},
				{"en": "Elijah", "pt": "Elias"}
			]
		},
		{
			"question":
			{
				"en": "Who hid the Israelite spies because she believed God would give the land?",
				"pt":
				"Quem escondeu os espiões israelitas porque acreditava que Deus daria a terra?"
			},
			"answer": {"en": "Rahab", "pt": "Raabe"},
			"tier": 1,
			"decoys":
			[
				{"en": "Delilah", "pt": "Dalila"},
				{"en": "Jael", "pt": "Jael"},
				{"en": "Vashti", "pt": "Vasti"}
			]
		},
		{
			"question":
			{
				"en": "Who prayed for a son and vowed to dedicate him to the Lord?",
				"pt": "Quem orou por um filho e jurou dedicá-lo ao Senhor?"
			},
			"answer": {"en": "Hannah", "pt": "Ana"},
			"tier": 2,
			"decoys":
			[
				{"en": "Leah", "pt": "Lia"},
				{"en": "Rachel", "pt": "Raquel"},
				{"en": "Miriam", "pt": "Míriam"}
			]
		},
		{
			"question":
			{
				"en": "Which widow trusted God and fed Elijah with her last bit of flour and oil?",
				"pt":
				"Qual viúva confiou em Deus e alimentou Elias com seu último pedaço de farinha e óleo?"
			},
			"answer": {"en": "The widow of Zarephath", "pt": "A viúva de Sarepta"},
			"tier": 2,
			"decoys":
			[
				{"en": "The widow at Nain", "pt": "A viúva de Naim"},
				{"en": "Mary", "pt": "Mary"},
				{"en": "Martha", "pt": "Marta"}
			]
		},
		{
			"question":
			{
				"en": "Who sent singers ahead of the army trusting God to fight the battle?",
				"pt":
				"Quem enviou cantores à frente do exército confiando em Deus para travar a batalha?"
			},
			"answer": {"en": "Jehoshaphat", "pt": "Josafá"},
			"tier": 3,
			"decoys":
			[
				{"en": "Ahab", "pt": "Acabe"},
				{"en": "Saul", "pt": "Saulo"},
				{"en": "Jeroboam", "pt": "Jeroboão"}
			]
		},
		{
			"question":
			{
				"en": "Who spread Sennacherib's threatening letter before the Lord in the temple?",
				"pt": "Quem divulgou a carta ameaçadora de Senaqueribe diante do Senhor no templo?"
			},
			"answer": {"en": "Hezekiah", "pt": "Ezequias"},
			"tier": 2,
			"decoys":
			[
				{"en": "Rehoboam", "pt": "Roboão"},
				{"en": "Josiah", "pt": "Josias"},
				{"en": "Uzziah", "pt": "Uzias"}
			]
		},
		{
			"question":
			{
				"en": "Who answered the angel, 'May it be to me according to your word'?",
				"pt": "Quem respondeu ao anjo: 'Faça-se em mim segundo a tua palavra'?"
			},
			"answer": {"en": "Mary", "pt": "Mary"},
			"tier": 1,
			"decoys":
			[
				{"en": "Martha", "pt": "Marta"},
				{"en": "Elizabeth", "pt": "Elisabete"},
				{"en": "Deborah", "pt": "Débora"}
			]
		},
		{
			"question":
			{
				"en":
				"Who trusted God's promise and asked for the hill country of Hebron at age eighty-five?",
				"pt":
				"Quem confiou na promessa de Deus e pediu a região montanhosa de Hebron aos oitenta e cinco anos?"
			},
			"answer": {"en": "Caleb", "pt": "Calebe"},
			"tier": 2,
			"decoys":
			[
				{"en": "Joshua", "pt": "Josué"},
				{"en": "Gideon", "pt": "Gideão"},
				{"en": "Samuel", "pt": "Samuel"}
			]
		},
		{
			"question":
			{
				"en": "Who stepped out of a boat in faith to walk toward Jesus on the water?",
				"pt":
				"Quem saiu de um barco com fé para caminhar em direção a Jesus sobre as águas?"
			},
			"answer": {"en": "Peter", "pt": "Peter"},
			"tier": 3,
			"decoys":
			[
				{"en": "John", "pt": "John"},
				{"en": "Andrew", "pt": "André"},
				{"en": "Thomas", "pt": "Tomás"}
			]
		},
		{
			"question":
			{
				"en": "Who resolved not to defile himself with the king's food in Babylon?",
				"pt": "Quem resolveu não se contaminar com a comida do rei na Babilônia?"
			},
			"answer": {"en": "Daniel", "pt": "Danilo"},
			"tier": 2,
			"decoys":
			[
				{"en": "Shadrach", "pt": "Sadraque"},
				{"en": "Nehemiah", "pt": "Neemias"},
				{"en": "Ezra", "pt": "Esdras"}
			]
		},
		{
			"question":
			{
				"en": "Who trusted God by giving two small coins at the temple treasury?",
				"pt": "Quem confiou em Deus ao dar duas pequenas moedas ao tesouro do templo?"
			},
			"answer": {"en": "The poor widow", "pt": "A viúva pobre"},
			"tier": 1,
			"decoys":
			[
				{"en": "Lydia", "pt": "Lídia"},
				{"en": "Priscilla", "pt": "Priscila"},
				{"en": "Dorcas", "pt": "Dorcas"}
			]
		},
		{
			"question":
			{
				"en": "Who offered five loaves and two fish that Jesus used to feed a multitude?",
				"pt":
				"Quem ofereceu cinco pães e dois peixes que Jesus usou para alimentar uma multidão?"
			},
			"answer": {"en": "A young boy", "pt": "Um menino"},
			"tier": 1,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "Andrew", "pt": "André"},
				{"en": "Philip", "pt": "Filipe"}
			]
		},
		{
			"question":
			{
				"en":
				"Who prayed for success finding a wife for Isaac and trusted God to lead him?",
				"pt":
				"Quem orou pedindo sucesso para encontrar uma esposa para Isaque e confiou em Deus para liderá-lo?"
			},
			"answer": {"en": "Abraham's servant", "pt": "Servo de Abraão"},
			"tier": 2,
			"decoys":
			[
				{"en": "Moses", "pt": "Moisés"},
				{"en": "Gideon", "pt": "Gideão"},
				{"en": "Balaam", "pt": "Balaão"}
			]
		},
		{
			"question":
			{
				"en": "Who said to Jesus, 'Only say the word and my servant will be healed'?",
				"pt": "Who said to Jesus, 'Only say the word and my servant will be healed'?"
			},
			"answer": {"en": "A Roman centurion", "pt": "A Roman centurion"},
			"tier": 2,
			"decoys":
			[
				{"en": "A synagogue ruler", "pt": "A synagogue ruler"},
				{"en": "A Pharisee", "pt": "A Pharisee"},
				{"en": "A scribe", "pt": "A scribe"}
			]
		},
		{
			"question":
			{
				"en":
				"Who marched around Jericho for seven days trusting God to bring down the walls?",
				"pt":
				"Who marched around Jericho for seven days trusting God to bring down the walls?"
			},
			"answer": {"en": "Israel under Joshua", "pt": "Israel under Joshua"},
			"tier": 2,
			"decoys":
			[
				{"en": "Israel under Moses", "pt": "Israel under Moses"},
				{"en": "Israel under David", "pt": "Israel under David"},
				{"en": "Israel under Gideon", "pt": "Israel under Gideon"}
			]
		},
		{
			"question":
			{
				"en": "Who dipped seven times in the Jordan to be healed of leprosy?",
				"pt": "Who dipped seven times in the Jordan to be healed of leprosy?"
			},
			"answer": {"en": "Naaman", "pt": "Naaman"},
			"tier": 3,
			"decoys":
			[
				{"en": "Gehazi", "pt": "Gehazi"},
				{"en": "Elisha", "pt": "Elisha"},
				{"en": "Hazael", "pt": "Hazael"}
			]
		},
		{
			"question":
			{
				"en": "Who filled many jars with oil after borrowing vessels by faith?",
				"pt": "Who filled many jars with oil after borrowing vessels by faith?"
			},
			"answer":
			{
				"en": "The widow of a prophet in Elisha's day",
				"pt": "The widow of a prophet in Elisha's day"
			},
			"tier": 3,
			"decoys":
			[
				{"en": "The Shunammite woman", "pt": "The Shunammite woman"},
				{"en": "The widow at Zarephath", "pt": "The widow at Zarephath"},
				{"en": "Ruth", "pt": "Ruth"}
			]
		},
		{
			"question":
			{
				"en": "Who rebuilt Jerusalem's wall with a sword and trowel despite threats?",
				"pt": "Who rebuilt Jerusalem's wall with a sword and trowel despite threats?"
			},
			"answer": {"en": "Nehemiah and his workers", "pt": "Nehemiah and his workers"},
			"tier": 3,
			"decoys":
			[
				{"en": "Ezra and the priests", "pt": "Ezra and the priests"},
				{"en": "Zerubbabel alone", "pt": "Zerubbabel alone"},
				{"en": "The Levites only", "pt": "The Levites only"}
			]
		},
		{
			"question":
			{
				"en": "Who risked death by approaching the king after a fast?",
				"pt": "Who risked death by approaching the king after a fast?"
			},
			"answer": {"en": "Esther", "pt": "Esther"},
			"tier": 3,
			"decoys":
			[
				{"en": "Vashti", "pt": "Vashti"},
				{"en": "Deborah", "pt": "Deborah"},
				{"en": "Bathsheba", "pt": "Bathsheba"}
			]
		},
		{
			"question":
			{
				"en": "Who prayed seven times for rain on Carmel until a cloud appeared?",
				"pt": "Who prayed seven times for rain on Carmel until a cloud appeared?"
			},
			"answer": {"en": "Elijah", "pt": "Elijah"},
			"tier": 3,
			"decoys":
			[
				{"en": "Elisha", "pt": "Elisha"},
				{"en": "Samuel", "pt": "Samuel"},
				{"en": "Haggai", "pt": "Haggai"}
			]
		},
		{
			"question":
			{
				"en": "Who asked the sun to stand still over Gibeon?",
				"pt": "Who asked the sun to stand still over Gibeon?"
			},
			"answer": {"en": "Joshua", "pt": "Joshua"},
			"tier": 3,
			"decoys":
			[
				{"en": "Moses", "pt": "Moses"},
				{"en": "Caleb", "pt": "Caleb"},
				{"en": "Barak", "pt": "Barak"}
			]
		},
		{
			"question":
			{
				"en": "Who took 300 men with trumpets and jars against Midian?",
				"pt": "Who took 300 men with trumpets and jars against Midian?"
			},
			"answer": {"en": "Gideon", "pt": "Gideon"},
			"tier": 3,
			"decoys":
			[
				{"en": "Jephthah", "pt": "Jephthah"},
				{"en": "Samson", "pt": "Samson"},
				{"en": "Ehud", "pt": "Ehud"}
			]
		},
		{
			"question":
			{
				"en": "Who encouraged shipmates in a storm saying an angel promised survival?",
				"pt": "Who encouraged shipmates in a storm saying an angel promised survival?"
			},
			"answer": {"en": "Paul", "pt": "Paul"},
			"tier": 3,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "Barnabas", "pt": "Barnabas"},
				{"en": "Silas", "pt": "Silas"}
			]
		}
	],
	"Forgiveness & Grace":
	[
		{
			"question":
			{
				"en": "Who forgave his brothers saying God meant it for good?",
				"pt": "Quem perdoou seus irmãos dizendo que Deus queria isso para o bem?"
			},
			"answer": {"en": "Joseph", "pt": "José"},
			"tier": 3,
			"decoys":
			[
				{"en": "Esau", "pt": "Esaú"},
				{"en": "Jacob", "pt": "Jacó"},
				{"en": "Judah", "pt": "Judá"}
			]
		},
		{
			"question":
			{
				"en": "Who forgave the crowd from the cross?",
				"pt": "Quem perdoou a multidão na cruz?"
			},
			"answer": {"en": "Jesus", "pt": "Jesus"},
			"tier": 1,
			"decoys":
			[
				{"en": "Stephen", "pt": "Estêvão"},
				{"en": "Paul", "pt": "Paulo"},
				{"en": "Peter", "pt": "Peter"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet preached to Nineveh offering mercy?",
				"pt": "Qual profeta pregou a Nínive oferecendo misericórdia?"
			},
			"answer": {"en": "Jonah", "pt": "Jonas"},
			"tier": 1,
			"decoys":
			[
				{"en": "Nahum", "pt": "Naum"},
				{"en": "Micah", "pt": "Miquéias"},
				{"en": "Hosea", "pt": "Oséias"}
			]
		},
		{
			"question":
			{
				"en": "Who restored Peter after denial with 'feed my sheep'?",
				"pt": "Quem restaurou Pedro após a negação de 'apascenta minhas ovelhas'?"
			},
			"answer": {"en": "Jesus", "pt": "Jesus"},
			"tier": 1,
			"decoys":
			[
				{"en": "Paul", "pt": "Paulo"},
				{"en": "James", "pt": "James"},
				{"en": "John", "pt": "John"}
			]
		},
		{
			"question":
			{
				"en": "Who pardoned David after his prayer in Psalm 51?",
				"pt": "Quem perdoou Davi depois de sua oração no Salmo 51?"
			},
			"answer": {"en": "God", "pt": "Deus"},
			"tier": 1,
			"decoys":
			[
				{"en": "Nathan", "pt": "Natan"},
				{"en": "Solomon", "pt": "Salomão"},
				{"en": "Absalom", "pt": "Absalão"}
			]
		},
		{
			"question":
			{
				"en": "Who ran to embrace his wayward son in Jesus' story?",
				"pt": "Quem correu para abraçar seu filho rebelde na história de Jesus?"
			},
			"answer": {"en": "The father of the prodigal son", "pt": "O pai do filho pródigo"},
			"tier": 1,
			"decoys":
			[
				{"en": "The older brother", "pt": "O irmão mais velho"},
				{"en": "The rich ruler", "pt": "O governante rico"},
				{"en": "The vineyard owner", "pt": "O dono da vinha"}
			]
		},
		{
			"question":
			{
				"en": "Who prayed, 'Lord, do not hold this sin against them' while being stoned?",
				"pt": "Quem orou: 'Senhor, não lhes imputes este pecado' enquanto era apedrejado?"
			},
			"answer": {"en": "Stephen", "pt": "Estêvão"},
			"tier": 1,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "John", "pt": "John"},
				{"en": "James", "pt": "James"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet bought back his unfaithful wife to show God's love?",
				"pt": "Qual profeta resgatou sua esposa infiel para mostrar o amor de Deus?"
			},
			"answer": {"en": "Hosea", "pt": "Oséias"},
			"tier": 2,
			"decoys":
			[
				{"en": "Malachi", "pt": "Malaquias"},
				{"en": "Micah", "pt": "Miquéias"},
				{"en": "Haggai", "pt": "Ageu"}
			]
		},
		{
			"question":
			{
				"en": "Who heard Jesus say, 'Neither do I condemn you; go and sin no more'?",
				"pt": "Que ouviu Jesus dizer: 'Nem eu te condeno; vá e não peque mais'?"
			},
			"answer": {"en": "The woman caught in adultery", "pt": "A mulher pega em adultério"},
			"tier": 1,
			"decoys":
			[
				{"en": "The Samaritan woman", "pt": "A mulher samaritana"},
				{"en": "Mary of Bethany", "pt": "Maria de Betânia"},
				{"en": "Martha", "pt": "Marta"}
			]
		},
		{
			"question":
			{
				"en": "Who embraced his brother Jacob instead of seeking revenge?",
				"pt": "Quem abraçou seu irmão Jacó em vez de buscar vingança?"
			},
			"answer": {"en": "Esau", "pt": "Esaú"},
			"tier": 2,
			"decoys":
			[
				{"en": "Ishmael", "pt": "Ismael"},
				{"en": "Laban", "pt": "Labão"},
				{"en": "Joseph", "pt": "José"}
			]
		},
		{
			"question":
			{
				"en": "Who spared King Saul in the cave, choosing mercy over vengeance?",
				"pt":
				"Quem poupou o rei Saul na caverna, escolhendo a misericórdia em vez da vingança?"
			},
			"answer": {"en": "David", "pt": "Davi"},
			"tier": 2,
			"decoys":
			[
				{"en": "Jonathan", "pt": "Jônatas"},
				{"en": "Abner", "pt": "Abner"},
				{"en": "Ishbosheth", "pt": "Isbosete"}
			]
		},
		{
			"question":
			{
				"en": "How many times did Jesus say to forgive a brother?",
				"pt": "Quantas vezes Jesus disse para perdoar um irmão?"
			},
			"answer": {"en": "Seventy times seven", "pt": "Setenta vezes sete"},
			"tier": 3,
			"decoys":
			[
				{"en": "Seven", "pt": "Sete"},
				{"en": "Three", "pt": "Três"},
				{"en": "Ten", "pt": "Dez"}
			]
		},
		{
			"question":
			{
				"en": "Which parable warns about refusing to forgive after being forgiven much?",
				"pt":
				"Qual parábola alerta sobre a recusa em perdoar depois de ter sido muito perdoado?"
			},
			"answer": {"en": "The Unforgiving Servant", "pt": "O servo implacável"},
			"tier": 2,
			"decoys":
			[
				{"en": "The Lost Coin", "pt": "A moeda perdida"},
				{"en": "The Ten Virgins", "pt": "As Dez Virgens"},
				{"en": "The Two Debtors", "pt": "Os dois devedores"}
			]
		},
		{
			"question":
			{
				"en":
				"Whose life of persecuting the church was turned by grace on the Damascus road?",
				"pt":
				"Cuja vida de perseguição à igreja foi transformada pela graça na estrada de Damasco?"
			},
			"answer": {"en": "Paul", "pt": "Paulo"},
			"tier": 2,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "James", "pt": "James"},
				{"en": "Annas", "pt": "Anás"}
			]
		},
		{
			"question":
			{
				"en": "Who washed Jesus' feet with her tears and was told her sins were forgiven?",
				"pt":
				"Quem lavou os pés de Jesus com as suas lágrimas e foi informado que os seus pecados estavam perdoados?"
			},
			"answer":
			{
				"en": "A sinful woman in Simon the Pharisee's house",
				"pt": "Uma mulher pecadora na casa de Simão, o fariseu"
			},
			"tier": 2,
			"decoys":
			[
				{"en": "Mary of Bethany", "pt": "Maria de Betânia"},
				{"en": "Martha", "pt": "Marta"},
				{"en": "Salome", "pt": "Salomé"}
			]
		},
		{
			"question":
			{
				"en": "Who heard Jesus say, 'Son, your sins are forgiven' before being healed?",
				"pt":
				"Quem ouviu Jesus dizer: ‘Filho, os teus pecados estão perdoados’ antes de ser curado?"
			},
			"answer":
			{
				"en": "The paralytic lowered through the roof",
				"pt": "O paralítico desceu pelo telhado"
			},
			"tier": 2,
			"decoys":
			[
				{"en": "The blind man of Jericho", "pt": "O cego de Jericó"},
				{"en": "Bartimaeus", "pt": "Bartimeu"},
				{"en": "The man at Bethesda", "pt": "O homem em Betesda"}
			]
		},
		{
			"question":
			{
				"en": "Which criminal heard, 'Today you will be with me in paradise'?",
				"pt": "Qual criminoso ouviu: 'Hoje você estará comigo no paraíso'?"
			},
			"answer":
			{"en": "The repentant thief on the cross", "pt": "O ladrão arrependido na cruz"},
			"tier": 1,
			"decoys":
			[
				{"en": "Barabbas", "pt": "Barrabás"},
				{"en": "The centurion", "pt": "O centurião"},
				{"en": "Judas", "pt": "Judas"}
			]
		},
		{
			"question":
			{
				"en": "Who welcomed Jesus into his home and repaid those he cheated fourfold?",
				"pt":
				"Quem acolheu Jesus em sua casa e retribuiu quatro vezes mais aqueles que ele enganou?"
			},
			"answer": {"en": "Zacchaeus", "pt": "Zaqueu"},
			"tier": 1,
			"decoys":
			[
				{"en": "Nicodemus", "pt": "Nicodemos"},
				{"en": "Levi", "pt": "Levi"},
				{"en": "Simon the leper", "pt": "Simão, o leproso"}
			]
		},
		{
			"question":
			{
				"en": "Who was urged by Paul to receive a runaway slave as a brother?",
				"pt": "Quem foi instado por Paulo a receber como irmão um escravo fugitivo?"
			},
			"answer": {"en": "Philemon", "pt": "Filemom"},
			"tier": 2,
			"decoys":
			[
				{"en": "Titus", "pt": "Tito"},
				{"en": "Timothy", "pt": "Timóteo"},
				{"en": "Apollos", "pt": "Apolo"}
			]
		},
		{
			"question":
			{
				"en": "What did God do when Nineveh repented at Jonah's preaching?",
				"pt": "O que Deus fez quando Nínive se arrependeu com a pregação de Jonas?"
			},
			"answer": {"en": "He relented from the disaster", "pt": "Ele cedeu ao desastre"},
			"tier": 1,
			"decoys":
			[
				{"en": "He sent another prophet", "pt": "Ele enviou outro profeta"},
				{"en": "He destroyed the city", "pt": "Ele destruiu a cidade"},
				{"en": "He scattered them to Babylon", "pt": "Ele os espalhou para a Babilônia"}
			]
		},
		{
			"question":
			{
				"en": "Who asked Jesus how many times to forgive and heard 'seventy-seven'?",
				"pt": "Who asked Jesus how many times to forgive and heard 'seventy-seven'?"
			},
			"answer": {"en": "Peter", "pt": "Peter"},
			"tier": 2,
			"decoys":
			[
				{"en": "John", "pt": "John"},
				{"en": "James", "pt": "James"},
				{"en": "Thomas", "pt": "Thomas"}
			]
		},
		{
			"question":
			{
				"en": "Who interceded after the golden calf asking God to forgive Israel?",
				"pt": "Who interceded after the golden calf asking God to forgive Israel?"
			},
			"answer": {"en": "Moses", "pt": "Moses"},
			"tier": 2,
			"decoys":
			[
				{"en": "Aaron", "pt": "Aaron"},
				{"en": "Joshua", "pt": "Joshua"},
				{"en": "Hur", "pt": "Hur"}
			]
		},
		{
			"question":
			{
				"en":
				"In the parable of the unforgiving servant, how much was the first debt forgiven?",
				"pt":
				"In the parable of the unforgiving servant, how much was the first debt forgiven?"
			},
			"answer": {"en": "Ten thousand talents", "pt": "Ten thousand talents"},
			"tier": 3,
			"decoys":
			[
				{"en": "One hundred talents", "pt": "One hundred talents"},
				{"en": "One hundred denarii", "pt": "One hundred denarii"},
				{"en": "A thousand shekels", "pt": "A thousand shekels"}
			]
		},
		{
			"question":
			{
				"en": "How much did the unforgiving servant demand from his fellow servant?",
				"pt": "How much did the unforgiving servant demand from his fellow servant?"
			},
			"answer": {"en": "One hundred denarii", "pt": "One hundred denarii"},
			"tier": 3,
			"decoys":
			[
				{"en": "Ten talents", "pt": "Ten talents"},
				{"en": "Five minas", "pt": "Five minas"},
				{"en": "A thousand shekels", "pt": "A thousand shekels"}
			]
		},
		{
			"question":
			{
				"en": "Who later called Mark useful again after once parting ways with him?",
				"pt": "Who later called Mark useful again after once parting ways with him?"
			},
			"answer": {"en": "Paul", "pt": "Paul"},
			"tier": 3,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "Barnabas", "pt": "Barnabas"},
				{"en": "Silas", "pt": "Silas"}
			]
		},
		{
			"question":
			{
				"en": "Who offered himself as surety for Benjamin so his brother could return?",
				"pt": "Who offered himself as surety for Benjamin so his brother could return?"
			},
			"answer": {"en": "Judah", "pt": "Judah"},
			"tier": 3,
			"decoys":
			[
				{"en": "Reuben", "pt": "Reuben"},
				{"en": "Levi", "pt": "Levi"},
				{"en": "Simeon", "pt": "Simeon"}
			]
		},
		{
			"question":
			{
				"en": "Who was the runaway slave Paul asked to receive as a brother?",
				"pt": "Who was the runaway slave Paul asked to receive as a brother?"
			},
			"answer": {"en": "Onesimus", "pt": "Onesimus"},
			"tier": 3,
			"decoys":
			[
				{"en": "Tychicus", "pt": "Tychicus"},
				{"en": "Silas", "pt": "Silas"},
				{"en": "Titus", "pt": "Titus"}
			]
		},
		{
			"question":
			{
				"en":
				"Which prophet sulked when God spared a wicked city and learned from a plant?",
				"pt": "Which prophet sulked when God spared a wicked city and learned from a plant?"
			},
			"answer": {"en": "Jonah", "pt": "Jonah"},
			"tier": 3,
			"decoys":
			[
				{"en": "Nahum", "pt": "Nahum"},
				{"en": "Micah", "pt": "Micah"},
				{"en": "Habakkuk", "pt": "Habakkuk"}
			]
		},
		{
			"question":
			{
				"en": "Who cursed David but was spared when the king returned to Jerusalem?",
				"pt": "Who cursed David but was spared when the king returned to Jerusalem?"
			},
			"answer": {"en": "Shimei", "pt": "Shimei"},
			"tier": 3,
			"decoys":
			[
				{"en": "Abishai", "pt": "Abishai"},
				{"en": "Joab", "pt": "Joab"},
				{"en": "Ittai", "pt": "Ittai"}
			]
		},
		{
			"question":
			{
				"en": "Who spared King Saul a second time, taking only his spear and jug?",
				"pt": "Who spared King Saul a second time, taking only his spear and jug?"
			},
			"answer": {"en": "David", "pt": "David"},
			"tier": 3,
			"decoys":
			[
				{"en": "Samuel", "pt": "Samuel"},
				{"en": "Jonathan", "pt": "Jonathan"},
				{"en": "Ish-bosheth", "pt": "Ish-bosheth"}
			]
		}
	],
	"Courage & Boldness":
	[
		{
			"question":
			{
				"en": "Who said 'As for me and my house, we will serve the Lord'?",
				"pt": "Quem disse 'Eu e minha casa serviremos ao Senhor'?"
			},
			"answer": {"en": "Joshua", "pt": "Josué"},
			"tier": 1,
			"decoys":
			[
				{"en": "Caleb", "pt": "Calebe"},
				{"en": "Moses", "pt": "Moisés"},
				{"en": "Gideon", "pt": "Gideão"}
			]
		},
		{
			"question":
			{
				"en": "Who confronted Ahab on Mount Carmel?",
				"pt": "Quem confrontou Acabe no Monte Carmelo?"
			},
			"answer": {"en": "Elijah", "pt": "Elias"},
			"tier": 1,
			"decoys":
			[
				{"en": "Elisha", "pt": "Eliseu"},
				{"en": "Micaiah", "pt": "Micaías"},
				{"en": "Obadiah", "pt": "Obadias"}
			]
		},
		{
			"question":
			{"en": "Who faced Goliath with a sling?", "pt": "Quem enfrentou Golias com uma funda?"},
			"answer": {"en": "David", "pt": "Davi"},
			"tier": 1,
			"decoys":
			[
				{"en": "Jonathan", "pt": "Jônatas"},
				{"en": "Samson", "pt": "Sansão"},
				{"en": "Abishai", "pt": "Abisai"}
			]
		},
		{
			"question":
			{
				"en": "Which queen went before the king saying 'If I perish, I perish'?",
				"pt": "Qual rainha foi diante do rei dizendo 'Se eu perecer, eu pereço'?"
			},
			"answer": {"en": "Esther", "pt": "Ester"},
			"tier": 1,
			"decoys":
			[
				{"en": "Vashti", "pt": "Vasti"},
				{"en": "Bathsheba", "pt": "Bate-Seba"},
				{"en": "Jezebel", "pt": "Jezabel"}
			]
		},
		{
			"question":
			{
				"en": "Who stood before the Sanhedrin declaring obedience to God?",
				"pt": "Quem se apresentou perante o Sinédrio declarando obediência a Deus?"
			},
			"answer": {"en": "Peter and John", "pt": "Pedro e João"},
			"tier": 2,
			"decoys":
			[
				{"en": "Paul and Barnabas", "pt": "Paulo e Barnabé"},
				{"en": "Stephen and Philip", "pt": "Estêvão e Filipe"},
				{"en": "James and Jude", "pt": "Tiago e Judas"}
			]
		},
		{
			"question":
			{
				"en": "Who refused to bow to Nebuchadnezzar's image and faced the fiery furnace?",
				"pt":
				"Quem se recusou a curvar-se diante da imagem de Nabucodonosor e enfrentou a fornalha ardente?"
			},
			"answer":
			{"en": "Shadrach, Meshach, and Abednego", "pt": "Sadraque, Mesaque e Abednego"},
			"tier": 1,
			"decoys":
			[
				{"en": "Daniel and friends", "pt": "Daniel e amigos"},
				{"en": "Moses and Aaron", "pt": "Moisés e Aarão"},
				{"en": "Joshua and Caleb", "pt": "Josué e Calebe"}
			]
		},
		{
			"question":
			{
				"en": "Who kept praying toward Jerusalem even when it meant a den of lions?",
				"pt":
				"Quem continuou orando por Jerusalém mesmo quando isso significava uma cova de leões?"
			},
			"answer": {"en": "Daniel", "pt": "Danilo"},
			"tier": 1,
			"decoys":
			[
				{"en": "Shadrach", "pt": "Sadraque"},
				{"en": "Nehemiah", "pt": "Neemias"},
				{"en": "Ezra", "pt": "Esdras"}
			]
		},
		{
			"question":
			{
				"en": "Who tore down his father's altar to Baal at night?",
				"pt": "Quem derrubou o altar de seu pai a Baal durante a noite?"
			},
			"answer": {"en": "Gideon", "pt": "Gideão"},
			"tier": 2,
			"decoys":
			[
				{"en": "Jephthah", "pt": "Jefté"},
				{"en": "Othniel", "pt": "Otniel"},
				{"en": "Samson", "pt": "Sansão"}
			]
		},
		{
			"question":
			{
				"en": "Who preached boldly before the council and was stoned?",
				"pt": "Quem pregou com ousadia perante o concílio e foi apedrejado?"
			},
			"answer": {"en": "Stephen", "pt": "Estêvão"},
			"tier": 2,
			"decoys":
			[
				{"en": "Barnabas", "pt": "Barnabé"},
				{"en": "Mark", "pt": "Marca"},
				{"en": "Philip", "pt": "Filipe"}
			]
		},
		{
			"question":
			{
				"en": "Who testified about Jesus before King Agrippa and Festus?",
				"pt": "Quem testemunhou sobre Jesus perante o Rei Agripa e Festo?"
			},
			"answer": {"en": "Paul", "pt": "Paulo"},
			"tier": 2,
			"decoys":
			[
				{"en": "Felix", "pt": "Félix"},
				{"en": "Peter", "pt": "Peter"},
				{"en": "Silas", "pt": "Silas"}
			]
		},
		{
			"question":
			{
				"en": "Who bravely asked the Persian king to rebuild Jerusalem's walls?",
				"pt": "Quem bravamente pediu ao rei persa que reconstruísse os muros de Jerusalém?"
			},
			"answer": {"en": "Nehemiah", "pt": "Neemias"},
			"tier": 3,
			"decoys":
			[
				{"en": "Ezra", "pt": "Esdras"},
				{"en": "Zerubbabel", "pt": "Zorobabel"},
				{"en": "Haggai", "pt": "Ageu"}
			]
		},
		{
			"question":
			{
				"en":
				"Who said 'We should go up and take possession of the land, for we can certainly do it'?",
				"pt":
				"Quem disse 'Deveríamos subir e tomar posse da terra, pois certamente podemos fazê-lo'?"
			},
			"answer": {"en": "Caleb", "pt": "Calebe"},
			"tier": 2,
			"decoys":
			[
				{"en": "Joshua", "pt": "Josué"},
				{"en": "Saul", "pt": "Saulo"},
				{"en": "Ishbosheth", "pt": "Isbosete"}
			]
		},
		{
			"question":
			{
				"en":
				"Who climbed up with his armor-bearer saying 'Perhaps the Lord will act on our behalf'?",
				"pt":
				"Quem subiu com o seu escudeiro dizendo: 'Talvez o Senhor atue em nosso favor'?"
			},
			"answer": {"en": "Jonathan", "pt": "Jônatas"},
			"tier": 3,
			"decoys":
			[
				{"en": "David and Abishai", "pt": "Davi e Abisai"},
				{"en": "Samson alone", "pt": "Sansão sozinho"},
				{"en": "Barak and his troops", "pt": "Baraque e suas tropas"}
			]
		},
		{
			"question":
			{
				"en": "Who hid Israel's spies on her roof despite danger?",
				"pt": "Quem escondeu os espiões de Israel no seu telhado, apesar do perigo?"
			},
			"answer": {"en": "Rahab", "pt": "Raabe"},
			"tier": 1,
			"decoys":
			[
				{"en": "Delilah", "pt": "Dalila"},
				{"en": "Bathsheba", "pt": "Bate-Seba"},
				{"en": "Michal", "pt": "Mical"}
			]
		},
		{
			"question":
			{
				"en": "Who drove a tent peg through Sisera to deliver Israel?",
				"pt": "Quem cravou uma estaca em Sísera para libertar Israel?"
			},
			"answer": {"en": "Jael", "pt": "Jael"},
			"tier": 2,
			"decoys":
			[
				{"en": "Deborah", "pt": "Débora"},
				{"en": "Delilah", "pt": "Dalila"},
				{"en": "Naomi", "pt": "Noemi"}
			]
		},
		{
			"question":
			{
				"en": "Who pushed apart the pillars of a Philistine temple?",
				"pt": "Quem destruiu os pilares de um templo filisteu?"
			},
			"answer": {"en": "Samson", "pt": "Sansão"},
			"tier": 1,
			"decoys":
			[
				{"en": "David", "pt": "Davi"},
				{"en": "Abraham", "pt": "Abraão"},
				{"en": "Peter", "pt": "Peter"}
			]
		},
		{
			"question":
			{
				"en": "Who refused to bow to Haman though it risked his life?",
				"pt":
				"Quem se recusou a curvar-se diante de Hamã, embora isso arriscasse a sua vida?"
			},
			"answer": {"en": "Mordecai", "pt": "Mordecai"},
			"tier": 2,
			"decoys":
			[
				{"en": "Haman", "pt": "Hamã"},
				{"en": "Ezra", "pt": "Esdras"},
				{"en": "Aaron", "pt": "Aarão"}
			]
		},
		{
			"question":
			{
				"en": "Who confronted King Saul with 'To obey is better than sacrifice'?",
				"pt": "Quem confrontou o rei Saul com 'Obedecer é melhor que sacrificar'?"
			},
			"answer": {"en": "Samuel", "pt": "Samuel"},
			"tier": 3,
			"decoys":
			[
				{"en": "Nathan", "pt": "Natan"},
				{"en": "Eli", "pt": "Eli"},
				{"en": "Gad", "pt": "Deus"}
			]
		},
		{
			"question":
			{
				"en": "Who confronted King David saying 'You are the man'?",
				"pt": "Quem confrontou o Rei David dizendo 'Você é o homem'?"
			},
			"answer": {"en": "Nathan", "pt": "Natan"},
			"tier": 2,
			"decoys":
			[
				{"en": "Samuel", "pt": "Samuel"},
				{"en": "Gad", "pt": "Deus"},
				{"en": "Isaiah", "pt": "Isaías"}
			]
		},
		{
			"question":
			{
				"en": "After threats, what did the apostles pray for in Acts 4?",
				"pt": "Depois das ameaças, o que os apóstolos oraram em Atos 4?"
			},
			"answer":
			{
				"en": "More boldness to speak God's word",
				"pt": "Mais ousadia para falar a palavra de Deus"
			},
			"tier": 2,
			"decoys":
			[
				{"en": "Protection to stop preaching", "pt": "Proteção para parar de pregar"},
				{"en": "Revenge on the council", "pt": "Vingança no conselho"},
				{"en": "A chance to form a rebellion", "pt": "Uma chance de formar uma rebelião"}
			]
		},
		{
			"question":
			{
				"en": "Who confronted Pharaoh with God's demand, 'Let my people go'?",
				"pt": "Who confronted Pharaoh with God's demand, 'Let my people go'?"
			},
			"answer": {"en": "Moses", "pt": "Moses"},
			"tier": 1,
			"decoys":
			[
				{"en": "Aaron", "pt": "Aaron"},
				{"en": "Joshua", "pt": "Joshua"},
				{"en": "Joseph", "pt": "Joseph"}
			]
		},
		{
			"question":
			{
				"en": "Who stepped out of the boat and walked on water toward Jesus?",
				"pt": "Who stepped out of the boat and walked on water toward Jesus?"
			},
			"answer": {"en": "Peter", "pt": "Peter"},
			"tier": 1,
			"decoys":
			[
				{"en": "John", "pt": "John"},
				{"en": "Andrew", "pt": "Andrew"},
				{"en": "Thomas", "pt": "Thomas"}
			]
		},
		{
			"question":
			{
				"en":
				"Who told the council, 'We cannot help speaking about what we have seen and heard'?",
				"pt":
				"Who told the council, 'We cannot help speaking about what we have seen and heard'?"
			},
			"answer": {"en": "Peter and John", "pt": "Peter and John"},
			"tier": 2,
			"decoys":
			[
				{"en": "Paul and Barnabas", "pt": "Paul and Barnabas"},
				{"en": "Stephen and Philip", "pt": "Stephen and Philip"},
				{"en": "James and Jude", "pt": "James and Jude"}
			]
		},
		{
			"question":
			{
				"en": "Who hid one hundred prophets of the LORD in caves from Jezebel?",
				"pt": "Who hid one hundred prophets of the LORD in caves from Jezebel?"
			},
			"answer": {"en": "Obadiah", "pt": "Obadiah"},
			"tier": 3,
			"decoys":
			[
				{"en": "Elisha", "pt": "Elisha"},
				{"en": "Jehu", "pt": "Jehu"},
				{"en": "Micaiah", "pt": "Micaiah"}
			]
		},
		{
			"question":
			{
				"en": "Who speared Zimri and Cozbi to stop a plague?",
				"pt": "Who speared Zimri and Cozbi to stop a plague?"
			},
			"answer": {"en": "Phinehas", "pt": "Phinehas"},
			"tier": 3,
			"decoys":
			[
				{"en": "Eleazar", "pt": "Eleazar"},
				{"en": "Nadab", "pt": "Nadab"},
				{"en": "Abihu", "pt": "Abihu"}
			]
		},
		{
			"question":
			{
				"en": "Who defended a lentil field when others fled?",
				"pt": "Who defended a lentil field when others fled?"
			},
			"answer": {"en": "Shammah son of Agee", "pt": "Shammah son of Agee"},
			"tier": 3,
			"decoys":
			[
				{"en": "Eleazar son of Dodai", "pt": "Eleazar son of Dodai"},
				{"en": "Asahel", "pt": "Asahel"},
				{"en": "Ira the Ithrite", "pt": "Ira the Ithrite"}
			]
		},
		{
			"question":
			{
				"en": "Who killed a lion in a pit on a snowy day?",
				"pt": "Who killed a lion in a pit on a snowy day?"
			},
			"answer": {"en": "Benaiah son of Jehoiada", "pt": "Benaiah son of Jehoiada"},
			"tier": 3,
			"decoys":
			[
				{"en": "Samson", "pt": "Samson"},
				{"en": "David", "pt": "David"},
				{"en": "Jehu", "pt": "Jehu"}
			]
		},
		{
			"question":
			{
				"en": "Who confronted Jeroboam at Bethel causing his hand to wither?",
				"pt": "Who confronted Jeroboam at Bethel causing his hand to wither?"
			},
			"answer": {"en": "A man of God from Judah", "pt": "A man of God from Judah"},
			"tier": 3,
			"decoys":
			[
				{"en": "Ahijah", "pt": "Ahijah"},
				{"en": "Elisha", "pt": "Elisha"},
				{"en": "Micah", "pt": "Micah"}
			]
		},
		{
			"question":
			{
				"en":
				"Which young king tore down idols and later led reforms beginning at age sixteen?",
				"pt":
				"Which young king tore down idols and later led reforms beginning at age sixteen?"
			},
			"answer": {"en": "Josiah", "pt": "Josiah"},
			"tier": 3,
			"decoys":
			[
				{"en": "Hezekiah", "pt": "Hezekiah"},
				{"en": "Uzziah", "pt": "Uzziah"},
				{"en": "Manasseh", "pt": "Manasseh"}
			]
		},
		{
			"question":
			{
				"en": "Who told King Ahab the truth though 400 prophets promised victory?",
				"pt": "Who told King Ahab the truth though 400 prophets promised victory?"
			},
			"answer": {"en": "Micaiah son of Imlah", "pt": "Micaiah son of Imlah"},
			"tier": 3,
			"decoys":
			[
				{"en": "Elijah", "pt": "Elijah"},
				{"en": "Elisha", "pt": "Elisha"},
				{"en": "Obadiah", "pt": "Obadiah"}
			]
		}
	],
	"Famous Bible Quotes":
	[
		{
			"question":
			{
				"en": "Who said 'The Lord is my shepherd'?",
				"pt": "Quem disse 'O Senhor é meu pastor'?"
			},
			"answer": {"en": "David", "pt": "Davi"},
			"tier": 1,
			"decoys":
			[
				{"en": "Moses", "pt": "Moisés"},
				{"en": "Asaph", "pt": "Asafe"},
				{"en": "Solomon", "pt": "Salomão"}
			]
		},
		{
			"question":
			{
				"en": "Who said 'Choose this day whom you will serve'?",
				"pt": "Quem disse 'Escolha hoje a quem você servirá'?"
			},
			"answer": {"en": "Joshua", "pt": "Josué"},
			"tier": 1,
			"decoys":
			[
				{"en": "Moses", "pt": "Moisés"},
				{"en": "Samuel", "pt": "Samuel"},
				{"en": "Gideon", "pt": "Gideão"}
			]
		},
		{
			"question":
			{
				"en": "Who said 'Before Abraham was, I am'?",
				"pt": "Quem disse 'Antes que Abraão existisse, eu sou'?"
			},
			"answer": {"en": "Jesus", "pt": "Jesus"},
			"tier": 2,
			"decoys":
			[
				{"en": "Moses", "pt": "Moisés"},
				{"en": "John the Baptist", "pt": "João Batista"},
				{"en": "Peter", "pt": "Peter"}
			]
		},
		{
			"question":
			{
				"en": "Who said 'Let justice roll down like waters'?",
				"pt": "Quem disse 'Deixe a justiça rolar como águas'?"
			},
			"answer": {"en": "Amos", "pt": "Amós"},
			"tier": 2,
			"decoys":
			[
				{"en": "Micah", "pt": "Miquéias"},
				{"en": "Isaiah", "pt": "Isaías"},
				{"en": "Jeremiah", "pt": "Jeremias"}
			]
		},
		{
			"question":
			{
				"en": "Who said 'What is truth?' to Jesus?",
				"pt": "Quem disse 'O que é a verdade?' para Jesus?"
			},
			"answer": {"en": "Pilate", "pt": "Pilatos"},
			"tier": 3,
			"decoys":
			[
				{"en": "Herod", "pt": "Herodes"},
				{"en": "Caiaphas", "pt": "Caifás"},
				{"en": "Felix", "pt": "Félix"}
			]
		},
		{
			"question":
			{
				"en": "Who said 'For God so loved the world'?",
				"pt": "Quem disse 'Porque Deus amou o mundo de tal maneira'?"
			},
			"answer": {"en": "Jesus", "pt": "Jesus"},
			"tier": 1,
			"decoys":
			[
				{"en": "John the Baptist", "pt": "João Batista"},
				{"en": "Peter", "pt": "Peter"},
				{"en": "Paul", "pt": "Paulo"}
			]
		},
		{
			"question":
			{"en": "Who said 'Here am I; send me'?", "pt": "Quem disse 'Aqui estou eu; envie-me'?"},
			"answer": {"en": "Isaiah", "pt": "Isaías"},
			"tier": 1,
			"decoys":
			[
				{"en": "Jeremiah", "pt": "Jeremias"},
				{"en": "Ezekiel", "pt": "Ezequiel"},
				{"en": "Samuel", "pt": "Samuel"}
			]
		},
		{
			"question":
			{
				"en": "Who wrote 'I can do all things through Christ who strengthens me'?",
				"pt": "Quem escreveu 'Posso todas as coisas em Cristo que me fortalece'?"
			},
			"answer": {"en": "Paul", "pt": "Paulo"},
			"tier": 1,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "John", "pt": "John"},
				{"en": "James", "pt": "James"}
			]
		},
		{
			"question":
			{
				"en": "Who penned 'In the beginning God created the heavens and the earth'?",
				"pt": "Quem escreveu 'No princípio Deus criou os céus e a terra'?"
			},
			"answer": {"en": "Moses", "pt": "Moisés"},
			"tier": 2,
			"decoys":
			[
				{"en": "Ezra", "pt": "Esdras"},
				{"en": "Nehemiah", "pt": "Neemias"},
				{"en": "David", "pt": "Davi"}
			]
		},
		{
			"question":
			{"en": "Who demanded, 'Let my people go'?", "pt": "Quem exigiu: 'Deixe meu povo ir'?"},
			"answer": {"en": "Moses", "pt": "Moisés"},
			"tier": 1,
			"decoys":
			[
				{"en": "Pharaoh", "pt": "faraó"},
				{"en": "Aaron", "pt": "Aarão"},
				{"en": "Joshua", "pt": "Josué"}
			]
		},
		{
			"question":
			{
				"en": "Who said 'I am not ashamed of the gospel'?",
				"pt": "Quem disse 'Não tenho vergonha do evangelho'?"
			},
			"answer": {"en": "Paul", "pt": "Paulo"},
			"tier": 2,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "James", "pt": "James"},
				{"en": "John", "pt": "John"}
			]
		},
		{
			"question":
			{
				"en": "Who pronounced, 'The Lord bless you and keep you'?",
				"pt": "Quem pronunciou: 'O Senhor te abençoe e te guarde'?"
			},
			"answer": {"en": "Aaron", "pt": "Aarão"},
			"tier": 2,
			"decoys":
			[
				{"en": "Moses", "pt": "Moisés"},
				{"en": "Joshua", "pt": "Josué"},
				{"en": "David", "pt": "Davi"}
			]
		},
		{
			"question":
			{
				"en": "Who declared, 'We must obey God rather than men'?",
				"pt": "Quem declarou: 'Devemos obedecer a Deus e não aos homens'?"
			},
			"answer": {"en": "Peter and the apostles", "pt": "Pedro e os apóstolos"},
			"tier": 2,
			"decoys":
			[
				{"en": "Paul and Silas", "pt": "Paulo e Silas"},
				{"en": "James and John", "pt": "Tiago e João"},
				{"en": "Herod and Pilate", "pt": "Herodes e Pilatos"}
			]
		},
		{
			"question":
			{
				"en": "Who heard, 'Be strong and courageous' before leading Israel?",
				"pt": "Quem ouviu: 'Seja forte e corajoso' antes de liderar Israel?"
			},
			"answer": {"en": "Joshua", "pt": "Josué"},
			"tier": 1,
			"decoys":
			[
				{"en": "Gideon", "pt": "Gideão"},
				{"en": "Caleb", "pt": "Calebe"},
				{"en": "Saul", "pt": "Saulo"}
			]
		},
		{
			"question":
			{
				"en": "Who heard Jesus say, 'My grace is sufficient for you'?",
				"pt": "Quem ouviu Jesus dizer: 'Minha graça te basta'?"
			},
			"answer": {"en": "Paul", "pt": "Paulo"},
			"tier": 2,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "John", "pt": "John"},
				{"en": "Thomas", "pt": "Tomás"}
			]
		},
		{
			"question":
			{
				"en": "Who said, 'You intended to harm me, but God intended it for good'?",
				"pt":
				"Quem disse: 'Você pretendia me prejudicar, mas Deus planejou isso para o bem'?"
			},
			"answer": {"en": "Joseph", "pt": "José"},
			"tier": 1,
			"decoys":
			[
				{"en": "Judah", "pt": "Judá"},
				{"en": "Benjamin", "pt": "Benjamin"},
				{"en": "Jacob", "pt": "Jacó"}
			]
		},
		{
			"question":
			{
				"en": "Who said, 'The joy of the Lord is your strength'?",
				"pt": "Quem disse: 'A alegria do Senhor é a sua força'?"
			},
			"answer": {"en": "Nehemiah", "pt": "Neemias"},
			"tier": 2,
			"decoys":
			[
				{"en": "Ezra", "pt": "Esdras"},
				{"en": "Haggai", "pt": "Ageu"},
				{"en": "Zerubbabel", "pt": "Zorobabel"}
			]
		},
		{
			"question":
			{
				"en":
				"Who said, 'The Lord gave and the Lord has taken away; blessed be the name of the Lord'?",
				"pt": "Quem disse: 'O Senhor deu e o Senhor tirou; bendito seja o nome do Senhor'?"
			},
			"answer": {"en": "Job", "pt": "Trabalho"},
			"tier": 1,
			"decoys":
			[
				{"en": "David", "pt": "Davi"},
				{"en": "Solomon", "pt": "Salomão"},
				{"en": "Elijah", "pt": "Elias"}
			]
		},
		{
			"question":
			{
				"en":
				"Who asked, 'What does the Lord require of you but to do justice, love mercy, and walk humbly with your God'?",
				"pt":
				"Quem perguntou: 'O que o Senhor exige de você, senão que pratique a justiça, ame a misericórdia e ande humildemente com o seu Deus'?"
			},
			"answer": {"en": "Micah", "pt": "Miquéias"},
			"tier": 2,
			"decoys":
			[
				{"en": "Isaiah", "pt": "Isaías"},
				{"en": "Amos", "pt": "Amós"},
				{"en": "Hosea", "pt": "Oséias"}
			]
		},
		{
			"question":
			{
				"en": "Who declared, 'The Lord is my light and my salvation; whom shall I fear?'?",
				"pt": "Que declarou: 'O Senhor é minha luz e minha salvação; a quem devo temer?'"
			},
			"answer": {"en": "David", "pt": "Davi"},
			"tier": 1,
			"decoys":
			[
				{"en": "Moses", "pt": "Moisés"},
				{"en": "Asaph", "pt": "Asafe"},
				{"en": "Solomon", "pt": "Salomão"}
			]
		},
		{
			"question":
			{
				"en": "Who said, 'The LORD will fight for you; you need only be still'?",
				"pt": "Who said, 'The LORD will fight for you; you need only be still'?"
			},
			"answer": {"en": "Moses", "pt": "Moses"},
			"tier": 2,
			"decoys":
			[
				{"en": "Joshua", "pt": "Joshua"},
				{"en": "Caleb", "pt": "Caleb"},
				{"en": "Aaron", "pt": "Aaron"}
			]
		},
		{
			"question":
			{
				"en": "Who said, 'Not by might nor by power, but by My Spirit'?",
				"pt": "Who said, 'Not by might nor by power, but by My Spirit'?"
			},
			"answer": {"en": "The LORD through Zechariah", "pt": "The LORD through Zechariah"},
			"tier": 3,
			"decoys":
			[
				{"en": "The LORD through Haggai", "pt": "The LORD through Haggai"},
				{"en": "The LORD through Malachi", "pt": "The LORD through Malachi"},
				{"en": "The LORD through Amos", "pt": "The LORD through Amos"}
			]
		},
		{
			"question":
			{
				"en": "Who said, 'He must increase, I must decrease'?",
				"pt": "Who said, 'He must increase, I must decrease'?"
			},
			"answer": {"en": "John the Baptist", "pt": "John the Baptist"},
			"tier": 3,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "Paul", "pt": "Paul"},
				{"en": "John the apostle", "pt": "John the apostle"}
			]
		},
		{
			"question":
			{
				"en": "Who said, 'For to me, to live is Christ and to die is gain'?",
				"pt": "Who said, 'For to me, to live is Christ and to die is gain'?"
			},
			"answer": {"en": "Paul", "pt": "Paul"},
			"tier": 3,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "James", "pt": "James"},
				{"en": "John", "pt": "John"}
			]
		},
		{
			"question":
			{
				"en": "Who said, 'I am the resurrection and the life'?",
				"pt": "Who said, 'I am the resurrection and the life'?"
			},
			"answer": {"en": "Jesus", "pt": "Jesus"},
			"tier": 3,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "Martha", "pt": "Martha"},
				{"en": "Lazarus", "pt": "Lazarus"}
			]
		},
		{
			"question":
			{
				"en": "Who said, 'Though he slay me, yet will I hope in him'?",
				"pt": "Who said, 'Though he slay me, yet will I hope in him'?"
			},
			"answer": {"en": "Job", "pt": "Job"},
			"tier": 3,
			"decoys":
			[
				{"en": "Habakkuk", "pt": "Habakkuk"},
				{"en": "David", "pt": "David"},
				{"en": "Jeremiah", "pt": "Jeremiah"}
			]
		},
		{
			"question":
			{
				"en": "Who said, 'For I know the plans I have for you'?",
				"pt": "Who said, 'For I know the plans I have for you'?"
			},
			"answer": {"en": "The LORD through Jeremiah", "pt": "The LORD through Jeremiah"},
			"tier": 3,
			"decoys":
			[
				{"en": "Isaiah", "pt": "Isaiah"},
				{"en": "Ezekiel", "pt": "Ezekiel"},
				{"en": "Micah", "pt": "Micah"}
			]
		},
		{
			"question":
			{
				"en": "Who said, 'My eyes have seen your salvation'?",
				"pt": "Who said, 'My eyes have seen your salvation'?"
			},
			"answer": {"en": "Simeon", "pt": "Simeon"},
			"tier": 3,
			"decoys":
			[
				{"en": "Zechariah", "pt": "Zechariah"},
				{"en": "Anna", "pt": "Anna"},
				{"en": "Philip", "pt": "Philip"}
			]
		},
		{
			"question":
			{
				"en":
				"Who said, 'I have fought the good fight, I have finished the race, I have kept the faith'?",
				"pt":
				"Who said, 'I have fought the good fight, I have finished the race, I have kept the faith'?"
			},
			"answer": {"en": "Paul", "pt": "Paul"},
			"tier": 3,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "John", "pt": "John"},
				{"en": "James", "pt": "James"}
			]
		},
		{
			"question":
			{
				"en":
				"Who said, 'If anyone would come after me, let him deny himself and take up his cross daily'?",
				"pt":
				"Who said, 'If anyone would come after me, let him deny himself and take up his cross daily'?"
			},
			"answer": {"en": "Jesus", "pt": "Jesus"},
			"tier": 3,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "James", "pt": "James"},
				{"en": "John", "pt": "John"}
			]
		}
	],
	"Who Said It?":
	[
		{
			"question":
			{
				"en": "Who asked, 'Am I my brother's keeper?'",
				"pt": "Quem perguntou: 'Sou o guardião do meu irmão?'"
			},
			"answer": {"en": "Cain", "pt": "Caim"},
			"tier": 1,
			"decoys":
			[
				{"en": "Abel", "pt": "Abel"},
				{"en": "Esau", "pt": "Esaú"},
				{"en": "Ishmael", "pt": "Ismael"}
			]
		},
		{
			"question":
			{"en": "Who said, 'Here am I; send me'?", "pt": "Quem disse: 'Aqui estou; envie-me'?"},
			"answer": {"en": "Isaiah", "pt": "Isaías"},
			"tier": 1,
			"decoys":
			[
				{"en": "Jeremiah", "pt": "Jeremias"},
				{"en": "Ezekiel", "pt": "Ezequiel"},
				{"en": "Samuel", "pt": "Samuel"}
			]
		},
		{
			"question":
			{
				"en": "Who told his brothers, 'You meant it for evil, but God meant it for good'?",
				"pt":
				"Quem disse a seus irmãos: 'Vocês pretendiam isso para o mal, mas Deus pretendia isso para o bem'?"
			},
			"answer": {"en": "Joseph", "pt": "José"},
			"tier": 1,
			"decoys":
			[
				{"en": "Judah", "pt": "Judá"},
				{"en": "Benjamin", "pt": "Benjamin"},
				{"en": "Jacob", "pt": "Jacó"}
			]
		},
		{
			"question":
			{
				"en": "Who exclaimed, 'My Lord and my God!' when he saw Jesus?",
				"pt": "Que exclamou: 'Meu Senhor e meu Deus!' quando ele viu Jesus?"
			},
			"answer": {"en": "Thomas", "pt": "Tomás"},
			"tier": 3,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "John", "pt": "John"},
				{"en": "Philip", "pt": "Filipe"}
			]
		},
		{
			"question":
			{
				"en": "Who asked Jesus, 'What is truth?'?",
				"pt": "Quem perguntou a Jesus: 'O que é a verdade?'?"
			},
			"answer": {"en": "Pontius Pilate", "pt": "Pôncio Pilatos"},
			"tier": 3,
			"decoys":
			[
				{"en": "Herod", "pt": "Herodes"},
				{"en": "Caiaphas", "pt": "Caifás"},
				{"en": "Felix", "pt": "Félix"}
			]
		},
		{
			"question":
			{
				"en": "Who said, 'Speak, Lord, for your servant is listening'?",
				"pt": "Quem disse: ‘Fala, Senhor, porque o teu servo está ouvindo’?"
			},
			"answer": {"en": "Samuel", "pt": "Samuel"},
			"tier": 1,
			"decoys":
			[
				{"en": "Eli", "pt": "Eli"},
				{"en": "Saul", "pt": "Saulo"},
				{"en": "David", "pt": "Davi"}
			]
		},
		{
			"question":
			{
				"en": "Who pledged, 'Where you go I will go... your people will be my people'?",
				"pt": "Quem prometeu: 'Onde você for, eu irei... seu povo será meu povo'?"
			},
			"answer": {"en": "Ruth", "pt": "Rute"},
			"tier": 1,
			"decoys":
			[
				{"en": "Orpah", "pt": "Orfa"},
				{"en": "Naomi", "pt": "Noemi"},
				{"en": "Esther", "pt": "Ester"}
			]
		},
		{
			"question":
			{
				"en": "Who said, 'If I perish, I perish'?",
				"pt": "Quem disse: 'Se eu perecer, eu pereço'?"
			},
			"answer": {"en": "Esther", "pt": "Ester"},
			"tier": 1,
			"decoys":
			[
				{"en": "Vashti", "pt": "Vasti"},
				{"en": "Deborah", "pt": "Débora"},
				{"en": "Jael", "pt": "Jael"}
			]
		},
		{
			"question":
			{
				"en": "Who declared, 'As for me and my household, we will serve the Lord'?",
				"pt": "Quem declarou: ‘Eu e minha casa serviremos ao Senhor’?"
			},
			"answer": {"en": "Joshua", "pt": "Josué"},
			"tier": 1,
			"decoys":
			[
				{"en": "Moses", "pt": "Moisés"},
				{"en": "Caleb", "pt": "Calebe"},
				{"en": "Samuel", "pt": "Samuel"}
			]
		},
		{
			"question":
			{
				"en": "Who said to Jesus, 'Lord, show us the Father, and it is enough for us'?",
				"pt": "Quem disse a Jesus: ‘Senhor, mostra-nos o Pai, e isso nos basta’?"
			},
			"answer": {"en": "Philip", "pt": "Filipe"},
			"tier": 2,
			"decoys":
			[
				{"en": "Thomas", "pt": "Tomás"},
				{"en": "Peter", "pt": "Peter"},
				{"en": "Andrew", "pt": "André"}
			]
		},
		{
			"question":
			{
				"en": "Who asked God for 'an understanding heart to govern'?",
				"pt": "Quem pediu a Deus “um coração compreensivo para governar”?"
			},
			"answer": {"en": "Solomon", "pt": "Salomão"},
			"tier": 2,
			"decoys":
			[
				{"en": "David", "pt": "Davi"},
				{"en": "Hezekiah", "pt": "Ezequias"},
				{"en": "Josiah", "pt": "Josias"}
			]
		},
		{
			"question":
			{
				"en": "Who proclaimed of Jesus, 'Behold, the Lamb of God'?",
				"pt": "Quem proclamou sobre Jesus: “Eis o Cordeiro de Deus”?"
			},
			"answer": {"en": "John the Baptist", "pt": "João Batista"},
			"tier": 1,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "Andrew", "pt": "André"},
				{"en": "Luke", "pt": "Lucas"}
			]
		},
		{
			"question":
			{
				"en":
				"Who said to Jesus, 'Lord, to whom shall we go? You have the words of eternal life'?",
				"pt":
				"Quem disse a Jesus: ‘Senhor, para quem iremos? Você tem as palavras de vida eterna?"
			},
			"answer": {"en": "Peter", "pt": "Peter"},
			"tier": 1,
			"decoys":
			[
				{"en": "John", "pt": "John"},
				{"en": "James", "pt": "James"},
				{"en": "Philip", "pt": "Filipe"}
			]
		},
		{
			"question":
			{
				"en": "Who prayed, 'God, be merciful to me, a sinner'?",
				"pt": "Quem orou: 'Deus, tenha misericórdia de mim, um pecador'?"
			},
			"answer":
			{
				"en": "The tax collector in Jesus' parable",
				"pt": "O cobrador de impostos na parábola de Jesus"
			},
			"tier": 2,
			"decoys":
			[
				{"en": "The Pharisee in the temple", "pt": "O fariseu no templo"},
				{"en": "The rich young ruler", "pt": "O jovem rico governante"},
				{"en": "Zacchaeus", "pt": "Zaqueu"}
			]
		},
		{
			"question":
			{
				"en":
				"Who replied to the angel, 'I am the Lord's servant. May your word to me be fulfilled'?",
				"pt":
				"Que respondeu ao anjo: 'Sou servo do Senhor. Que sua palavra para mim seja cumprida?"
			},
			"answer": {"en": "Mary", "pt": "Mary"},
			"tier": 1,
			"decoys":
			[
				{"en": "Martha", "pt": "Marta"},
				{"en": "Elizabeth", "pt": "Elisabete"},
				{"en": "Anna", "pt": "Ana"}
			]
		},
		{
			"question":
			{
				"en": "Who said, 'Even if He does not rescue us, we will not bow to your image'?",
				"pt":
				"Quem disse: 'Mesmo que Ele não nos resgate, não nos curvaremos à sua imagem'?"
			},
			"answer":
			{"en": "Shadrach, Meshach, and Abednego", "pt": "Sadraque, Mesaque e Abednego"},
			"tier": 2,
			"decoys":
			[
				{"en": "Daniel", "pt": "Danilo"},
				{"en": "Mordecai", "pt": "Mordecai"},
				{"en": "Nehemiah", "pt": "Neemias"}
			]
		},
		{
			"question":
			{
				"en": "Who responded to Paul, 'Almost you persuade me to be a Christian'?",
				"pt": "Quem respondeu a Paulo: 'Quase você me convenceu a ser cristão'?"
			},
			"answer": {"en": "King Agrippa", "pt": "Rei Agripa"},
			"tier": 3,
			"decoys":
			[
				{"en": "Festus", "pt": "Festo"},
				{"en": "Felix", "pt": "Félix"},
				{"en": "Herod Antipas", "pt": "Herodes Antipas"}
			]
		},
		{
			"question":
			{
				"en": "Who cried out on the Damascus road, 'Who are you, Lord?'?",
				"pt": "Quem gritou na estrada de Damasco: 'Quem és, Senhor?'?"
			},
			"answer": {"en": "Saul/Paul", "pt": "Saulo/Paulo"},
			"tier": 3,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "Barnabas", "pt": "Barnabé"},
				{"en": "Silas", "pt": "Silas"}
			]
		},
		{
			"question":
			{
				"en": "Who declared, 'I know that my Redeemer lives'?",
				"pt": "Quem declarou: 'Eu sei que meu Redentor vive'?"
			},
			"answer": {"en": "Job", "pt": "Trabalho"},
			"tier": 2,
			"decoys":
			[
				{"en": "David", "pt": "Davi"},
				{"en": "Isaiah", "pt": "Isaías"},
				{"en": "Habakkuk", "pt": "Habacuque"}
			]
		},
		{
			"question":
			{
				"en": "Who finished his book praying, 'Come, Lord Jesus'?",
				"pt": "Quem terminou seu livro orando: 'Vem, Senhor Jesus'?"
			},
			"answer": {"en": "John", "pt": "John"},
			"tier": 2,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "Paul", "pt": "Paulo"},
				{"en": "Jude", "pt": "Judas"}
			]
		},
		{
			"question":
			{
				"en": "Who asked, 'How can this be, since I am a virgin'?",
				"pt": "Who asked, 'How can this be, since I am a virgin'?"
			},
			"answer": {"en": "Mary", "pt": "Mary"},
			"tier": 2,
			"decoys":
			[
				{"en": "Elizabeth", "pt": "Elizabeth"},
				{"en": "Martha", "pt": "Martha"},
				{"en": "Anna", "pt": "Anna"}
			]
		},
		{
			"question":
			{
				"en": "Who said, 'Come, let us rebuild the wall of Jerusalem'?",
				"pt": "Who said, 'Come, let us rebuild the wall of Jerusalem'?"
			},
			"answer": {"en": "Nehemiah", "pt": "Nehemiah"},
			"tier": 2,
			"decoys":
			[
				{"en": "Ezra", "pt": "Ezra"},
				{"en": "Zerubbabel", "pt": "Zerubbabel"},
				{"en": "Joash", "pt": "Joash"}
			]
		},
		{
			"question":
			{
				"en": "Who said, 'Sun, stand still over Gibeon'?",
				"pt": "Who said, 'Sun, stand still over Gibeon'?"
			},
			"answer": {"en": "Joshua", "pt": "Joshua"},
			"tier": 2,
			"decoys":
			[
				{"en": "Moses", "pt": "Moses"},
				{"en": "Caleb", "pt": "Caleb"},
				{"en": "Gideon", "pt": "Gideon"}
			]
		},
		{
			"question":
			{
				"en":
				"Who said, 'Lord, I am not worthy to have you come under my roof; only say the word'?",
				"pt":
				"Who said, 'Lord, I am not worthy to have you come under my roof; only say the word'?"
			},
			"answer": {"en": "The centurion at Capernaum", "pt": "The centurion at Capernaum"},
			"tier": 2,
			"decoys":
			[
				{"en": "The nobleman at Cana", "pt": "The nobleman at Cana"},
				{"en": "Jairus", "pt": "Jairus"},
				{"en": "Bartimaeus", "pt": "Bartimaeus"}
			]
		},
		{
			"question":
			{
				"en":
				"Who said, 'It is better that one man die for the people than the whole nation perish'?",
				"pt":
				"Who said, 'It is better that one man die for the people than the whole nation perish'?"
			},
			"answer": {"en": "Caiaphas", "pt": "Caiaphas"},
			"tier": 3,
			"decoys":
			[
				{"en": "Pilate", "pt": "Pilate"},
				{"en": "Herod", "pt": "Herod"},
				{"en": "Gamaliel", "pt": "Gamaliel"}
			]
		},
		{
			"question":
			{
				"en": "Who said, 'Who is the LORD that I should obey his voice to let Israel go'?",
				"pt": "Who said, 'Who is the LORD that I should obey his voice to let Israel go'?"
			},
			"answer": {"en": "Pharaoh", "pt": "Pharaoh"},
			"tier": 3,
			"decoys":
			[
				{"en": "Nebuchadnezzar", "pt": "Nebuchadnezzar"},
				{"en": "Balak", "pt": "Balak"},
				{"en": "Sennacherib", "pt": "Sennacherib"}
			]
		},
		{
			"question":
			{
				"en": "Who said, 'Is not this the great Babylon I have built'?",
				"pt": "Who said, 'Is not this the great Babylon I have built'?"
			},
			"answer": {"en": "Nebuchadnezzar", "pt": "Nebuchadnezzar"},
			"tier": 3,
			"decoys":
			[
				{"en": "Belshazzar", "pt": "Belshazzar"},
				{"en": "Darius", "pt": "Darius"},
				{"en": "Artaxerxes", "pt": "Artaxerxes"}
			]
		},
		{
			"question":
			{
				"en": "Who said, 'Surely this man was the Son of God' at the cross?",
				"pt": "Who said, 'Surely this man was the Son of God' at the cross?"
			},
			"answer": {"en": "A Roman centurion", "pt": "A Roman centurion"},
			"tier": 3,
			"decoys":
			[
				{"en": "Pilate", "pt": "Pilate"},
				{"en": "Herod", "pt": "Herod"},
				{"en": "Caiaphas", "pt": "Caiaphas"}
			]
		},
		{
			"question":
			{
				"en":
				"Who said, 'I see heaven open and the Son of Man standing at the right hand of God'?",
				"pt":
				"Who said, 'I see heaven open and the Son of Man standing at the right hand of God'?"
			},
			"answer": {"en": "Stephen", "pt": "Stephen"},
			"tier": 3,
			"decoys":
			[
				{"en": "Peter", "pt": "Peter"},
				{"en": "John", "pt": "John"},
				{"en": "James", "pt": "James"}
			]
		},
		{
			"question":
			{
				"en": "Who said, 'You are the man!' to confront King David?",
				"pt": "Who said, 'You are the man!' to confront King David?"
			},
			"answer": {"en": "Nathan", "pt": "Nathan"},
			"tier": 3,
			"decoys":
			[
				{"en": "Samuel", "pt": "Samuel"},
				{"en": "Gad", "pt": "Gad"},
				{"en": "Joab", "pt": "Joab"}
			]
		}
	],
	"Heroes of Faith (Hebrews 11)":
	[
		{
			"question":
			{
				"en": "Who built an ark to save his family?",
				"pt": "Quem construiu uma arca para salvar sua família?"
			},
			"answer": {"en": "Noah", "pt": "Noé"},
			"tier": 1,
			"decoys":
			[
				{"en": "Abraham", "pt": "Abraão"},
				{"en": "Moses", "pt": "Moisés"},
				{"en": "Job", "pt": "Trabalho"}
			]
		},
		{
			"question":
			{
				"en": "Who left his homeland not knowing where he was going?",
				"pt": "Quem saiu da sua terra natal sem saber para onde ia?"
			},
			"answer": {"en": "Abraham", "pt": "Abraão"},
			"tier": 1,
			"decoys":
			[
				{"en": "Lot", "pt": "Muito"},
				{"en": "Jacob", "pt": "Jacó"},
				{"en": "Isaac", "pt": "Isaque"}
			]
		},
		{
			"question":
			{
				"en": "Who received strength to conceive because she trusted God?",
				"pt": "Quem recebeu forças para conceber porque confiou em Deus?"
			},
			"answer": {"en": "Sarah", "pt": "Sara"},
			"tier": 1,
			"decoys":
			[
				{"en": "Rebekah", "pt": "Rebeca"},
				{"en": "Rachel", "pt": "Raquel"},
				{"en": "Hannah", "pt": "Ana"}
			]
		},
		{
			"question":
			{
				"en": "Who chose to suffer with God's people rather than enjoy sin for a season?",
				"pt":
				"Quem escolheu sofrer com o povo de Deus em vez de desfrutar do pecado por um tempo?"
			},
			"answer": {"en": "Moses", "pt": "Moisés"},
			"tier": 2,
			"decoys":
			[
				{"en": "Joseph", "pt": "José"},
				{"en": "Daniel", "pt": "Danilo"},
				{"en": "Nehemiah", "pt": "Neemias"}
			]
		},
		{
			"question":
			{
				"en": "Who welcomed spies in peace and was not destroyed with the disobedient?",
				"pt": "Quem acolheu os espiões em paz e não foi destruído com os desobedientes?"
			},
			"answer": {"en": "Rahab", "pt": "Raabe"},
			"tier": 2,
			"decoys":
			[
				{"en": "Deborah", "pt": "Débora"},
				{"en": "Jael", "pt": "Jael"},
				{"en": "Ruth", "pt": "Rute"}
			]
		},
		{
			"question":
			{
				"en": "Who blessed Jacob and Esau regarding things to come?",
				"pt": "Quem abençoou Jacó e Esaú em relação às coisas que viriam?"
			},
			"answer": {"en": "Isaac", "pt": "Isaque"},
			"tier": 2,
			"decoys":
			[
				{"en": "Jacob blessing Joseph's sons", "pt": "Jacó abençoando os filhos de José"},
				{"en": "Moses", "pt": "Moisés"},
				{"en": "Joseph", "pt": "José"}
			]
		},
		{
			"question":
			{
				"en": "Who blessed Joseph's sons while leaning on his staff?",
				"pt": "Quem abençoou os filhos de José apoiado em seu cajado?"
			},
			"answer": {"en": "Jacob", "pt": "Jacó"},
			"tier": 2,
			"decoys":
			[
				{"en": "Isaac", "pt": "Isaque"},
				{"en": "Abraham", "pt": "Abraão"},
				{"en": "Esau", "pt": "Esaú"}
			]
		},
		{
			"question":
			{
				"en": "Who gave instructions about his bones being carried out of Egypt?",
				"pt": "Quem deu instruções sobre a retirada de seus ossos do Egito?"
			},
			"answer": {"en": "Joseph", "pt": "José"},
			"tier": 2,
			"decoys":
			[
				{"en": "Moses", "pt": "Moisés"},
				{"en": "Joshua", "pt": "Josué"},
				{"en": "Aaron", "pt": "Aarão"}
			]
		},
		{
			"question":
			{
				"en": "Whose parents hid him for three months, seeing he was no ordinary child?",
				"pt":
				"Cujos pais o esconderam por três meses, visto que ele não era uma criança comum?"
			},
			"answer": {"en": "Moses' parents", "pt": "Os pais de Moisés"},
			"tier": 2,
			"decoys":
			[
				{"en": "Pharaoh's daughter", "pt": "Filha do Faraó"},
				{"en": "Zipporah", "pt": "Zípora"},
				{"en": "Miriam", "pt": "Míriam"}
			]
		},
		{
			"question":
			{
				"en": "Who passed through the Red Sea as on dry land?",
				"pt": "Quem passou pelo Mar Vermelho como se fosse em terra firme?"
			},
			"answer": {"en": "The Israelites", "pt": "Os israelitas"},
			"tier": 1,
			"decoys":
			[
				{
					"en": "The priests crossing the Jordan",
					"pt": "Os sacerdotes atravessando o Jordão"
				},
				{"en": "The Assyrians", "pt": "Os assírios"},
				{"en": "The Philistines", "pt": "Os filisteus"}
			]
		},
		{
			"question":
			{
				"en": "Whose walls fell after being marched around for seven days?",
				"pt": "Quais muros caíram depois de serem marchados por sete dias?"
			},
			"answer": {"en": "The walls of Jericho", "pt": "As muralhas de Jericó"},
			"tier": 1,
			"decoys":
			[
				{"en": "The walls of Ai", "pt": "As muralhas de Ai"},
				{"en": "The walls of Samaria", "pt": "Os muros de Samaria"},
				{"en": "The walls of Babylon", "pt": "As muralhas da Babilônia"}
			]
		},
		{
			"question":
			{
				"en": "Which judge conquered with a tiny army armed with torches and jars?",
				"pt": "Qual juiz conquistou com um pequeno exército armado com tochas e potes?"
			},
			"answer": {"en": "Gideon", "pt": "Gideão"},
			"tier": 2,
			"decoys":
			[
				{"en": "Barak", "pt": "Baraque"},
				{"en": "Saul", "pt": "Saulo"},
				{"en": "Jephthah", "pt": "Jefté"}
			]
		},
		{
			"question":
			{
				"en": "Which commander went into battle with Deborah leading him?",
				"pt": "Qual comandante entrou em batalha com Débora liderando-o?"
			},
			"answer": {"en": "Barak", "pt": "Baraque"},
			"tier": 3,
			"decoys":
			[
				{"en": "Gideon", "pt": "Gideão"},
				{"en": "Samson", "pt": "Sansão"},
				{"en": "Abimelech", "pt": "Abimeleque"}
			]
		},
		{
			"question":
			{
				"en":
				"Which Nazarite judge is listed among those who through faith conquered kingdoms?",
				"pt":
				"Qual juiz nazireu está alistado entre aqueles que pela fé conquistaram reinos?"
			},
			"answer": {"en": "Samson", "pt": "Sansão"},
			"tier": 3,
			"decoys":
			[
				{"en": "Jephthah", "pt": "Jefté"},
				{"en": "Boaz", "pt": "Boaz"},
				{"en": "Samuel", "pt": "Samuel"}
			]
		},
		{
			"question":
			{
				"en": "Which judge made a rash vow yet is listed among the faithful?",
				"pt": "Qual juiz fez um voto precipitado e ainda está listado entre os fiéis?"
			},
			"answer": {"en": "Jephthah", "pt": "Jefté"},
			"tier": 3,
			"decoys":
			[
				{"en": "Samson", "pt": "Sansão"},
				{"en": "Gideon", "pt": "Gideão"},
				{"en": "Barak", "pt": "Baraque"}
			]
		},
		{
			"question":
			{
				"en": "Which king is named among those who conquered kingdoms through faith?",
				"pt": "Qual rei é nomeado entre aqueles que conquistaram reinos pela fé?"
			},
			"answer": {"en": "David", "pt": "Davi"},
			"tier": 1,
			"decoys":
			[
				{"en": "Saul", "pt": "Saulo"},
				{"en": "Solomon", "pt": "Salomão"},
				{"en": "Absalom", "pt": "Absalão"}
			]
		},
		{
			"question":
			{
				"en": "Which prophet is grouped with Samuel among the faithful?",
				"pt": "Qual profeta está agrupado com Samuel entre os fiéis?"
			},
			"answer": {"en": "The prophets in general", "pt": "Os profetas em geral"},
			"tier": 2,
			"decoys":
			[
				{"en": "The kings", "pt": "Os reis"},
				{"en": "The Levites", "pt": "Os levitas"},
				{"en": "The priests", "pt": "Os sacerdotes"}
			]
		},
		{
			"question":
			{
				"en": "Who received their dead back to life again through faith?",
				"pt": "Quem recebeu seus mortos de volta à vida pela fé?"
			},
			"answer":
			{
				"en": "Women in the days of Elijah and Elisha",
				"pt": "Mulheres nos dias de Elias e Eliseu"
			},
			"tier": 3,
			"decoys":
			[
				{"en": "Men received kingdoms", "pt": "Os homens receberam reinos"},
				{"en": "Priests received tithes", "pt": "Os sacerdotes recebiam o dízimo"},
				{"en": "Children received bread", "pt": "As crianças receberam pão"}
			]
		},
		{
			"question":
			{
				"en": "Who by faith shut the mouths of lions?",
				"pt": "Quem pela fé fechou a boca dos leões?"
			},
			"answer": {"en": "Daniel", "pt": "Danilo"},
			"tier": 2,
			"decoys":
			[
				{"en": "Jeremiah", "pt": "Jeremias"},
				{"en": "Ezekiel", "pt": "Ezequiel"},
				{"en": "Hosea", "pt": "Oséias"}
			]
		},
		{
			"question":
			{
				"en": "Who quenched the fury of flames by trusting God?",
				"pt": "Quem apagou a fúria das chamas confiando em Deus?"
			},
			"answer":
			{"en": "Shadrach, Meshach, and Abednego", "pt": "Sadraque, Mesaque e Abednego"},
			"tier": 2,
			"decoys":
			[
				{"en": "David and his mighty men", "pt": "Davi e seus homens poderosos"},
				{"en": "Samson", "pt": "Sansão"},
				{"en": "Jonathan", "pt": "Jônatas"}
			]
		},
		{
			"question":
			{
				"en":
				"Who offered to God a better sacrifice than his brother and was commended as righteous?",
				"pt":
				"Quem ofereceu a Deus um sacrifício melhor do que o de seu irmão e foi considerado justo?"
			},
			"answer": {"en": "Abel", "pt": "Abel"},
			"tier": 1,
			"decoys":
			[
				{"en": "Cain", "pt": "Caim"},
				{"en": "Enoch", "pt": "Enoque"},
				{"en": "Noah", "pt": "Noé"}
			]
		},
		{
			"question":
			{
				"en": "Who walked with God and was taken so that he did not experience death?",
				"pt": "Quem andou com Deus e foi levado, para não ver a morte?"
			},
			"answer": {"en": "Enoch", "pt": "Enoque"},
			"tier": 2,
			"decoys":
			[
				{"en": "Elijah", "pt": "Elias"},
				{"en": "Moses", "pt": "Moisés"},
				{"en": "Daniel", "pt": "Daniel"}
			]
		},
		{
			"question":
			{
				"en":
				"Who was willing to offer his only son, believing God could raise him from the dead?",
				"pt":
				"Quem esteve disposto a oferecer seu filho único, crendo que Deus podia ressuscitá-lo dentre os mortos?"
			},
			"answer": {"en": "Abraham", "pt": "Abraão"},
			"tier": 2,
			"decoys":
			[
				{"en": "Isaac", "pt": "Isaque"},
				{"en": "Jacob", "pt": "Jacó"},
				{"en": "Jephthah", "pt": "Jefté"}
			]
		},
		{
			"question":
			{
				"en":
				"Who lived in tents in the promised land, looking forward to a city whose architect is God?",
				"pt":
				"Quem viveu em tendas na terra prometida, esperando uma cidade cujo arquiteto é Deus?"
			},
			"answer": {"en": "Abraham", "pt": "Abraão"},
			"tier": 2,
			"decoys":
			[
				{"en": "Lot", "pt": "Ló"},
				{"en": "Joshua", "pt": "Josué"},
				{"en": "Caleb", "pt": "Calebe"}
			]
		},
		{
			"question":
			{
				"en":
				"Which parents were not afraid of the king’s command and hid their child by faith?",
				"pt": "Quais pais não temeram o decreto do rei e esconderam seu filho pela fé?"
			},
			"answer": {"en": "Moses’ parents", "pt": "Os pais de Moisés"},
			"tier": 2,
			"decoys":
			[
				{"en": "Samuel’s parents", "pt": "Os pais de Samuel"},
				{"en": "John the Baptist’s parents", "pt": "Os pais de João Batista"},
				{"en": "Jesus’ parents", "pt": "Os pais de Jesus"}
			]
		},
		{
			"question":
			{
				"en":
				"Who kept the Passover and the sprinkling of blood so that the destroyer would not touch Israel’s firstborn?",
				"pt":
				"Quem celebrou a Páscoa e a aspersão do sangue para que o destruidor não tocasse os primogênitos de Israel?"
			},
			"answer": {"en": "Moses", "pt": "Moisés"},
			"tier": 3,
			"decoys":
			[
				{"en": "Aaron", "pt": "Arão"},
				{"en": "Joshua", "pt": "Josué"},
				{"en": "Phinehas", "pt": "Fineias"}
			]
		},
		{
			"question":
			{
				"en":
				"Who refused to be called the son of Pharaoh’s daughter, choosing mistreatment with God’s people?",
				"pt":
				"Quem recusou ser chamado filho da filha de Faraó, escolhendo ser maltratado com o povo de Deus?"
			},
			"answer": {"en": "Moses", "pt": "Moisés"},
			"tier": 2,
			"decoys":
			[
				{"en": "Joseph", "pt": "José"},
				{"en": "Daniel", "pt": "Daniel"},
				{"en": "Nehemiah", "pt": "Neemias"}
			]
		},
		{
			"question":
			{
				"en":
				"Who were tortured, refusing release so that they might gain a better resurrection?",
				"pt":
				"Quem foi torturado, não aceitando ser libertado, para alcançar uma melhor ressurreição?"
			},
			"answer": {"en": "Unnamed martyrs of faith", "pt": "Mártires anônimos da fé"},
			"tier": 3,
			"decoys":
			[
				{"en": "The Maccabees", "pt": "Os Macabeus"},
				{"en": "The apostles", "pt": "Os apóstolos"},
				{"en": "The prophets", "pt": "Os profetas"}
			]
		},
		{
			"question":
			{
				"en": "Who were sawn in two, stoned, and killed with the sword for their faith?",
				"pt": "Quem foi serrado ao meio, apedrejado e morto à espada por causa da fé?"
			},
			"answer":
			{
				"en": "Unnamed prophets mentioned among the faithful",
				"pt": "Profetas anônimos citados entre os fiéis"
			},
			"tier": 3,
			"decoys":
			[
				{"en": "The Levites", "pt": "Os levitas"},
				{"en": "The judges", "pt": "Os juízes"},
				{"en": "The kings", "pt": "Os reis"}
			]
		},
		{
			"question":
			{
				"en":
				"Who wandered in deserts, mountains, caves, and holes in the ground, of whom the world was not worthy?",
				"pt":
				"Quem andou por desertos, montes, covas e cavernas, dos quais o mundo não era digno?"
			},
			"answer":
			{
				"en": "Persecuted believers listed at the end of Hebrews 11",
				"pt": "Crentes perseguidos citados no final de Hebreus 11"
			},
			"tier": 3,
			"decoys":
			[
				{"en": "The twelve apostles", "pt": "Os doze apóstolos"},
				{"en": "The seventy disciples", "pt": "Os setenta discípulos"},
				{"en": "The Pharisees", "pt": "Os fariseus"}
			]
		}
	],
	"Kings of Israel & Judah":
	[
		{
			"question":
			{"en": "Who was the first king of Israel?", "pt": "Quem foi o primeiro rei de Israel?"},
			"answer": {"en": "Saul", "pt": "Saul"},
			"tier": 1,
			"decoys":
			[
				{"en": "David", "pt": "Davi"},
				{"en": "Solomon", "pt": "Salomão"},
				{"en": "Samuel", "pt": "Samuel"}
			]
		},
		{
			"question":
			{
				"en": "Which king killed Goliath when he was still a young shepherd?",
				"pt": "Qual rei matou Golias quando ainda era um jovem pastor?"
			},
			"answer": {"en": "David", "pt": "Davi"},
			"tier": 1,
			"decoys":
			[
				{"en": "Saul", "pt": "Saul"},
				{"en": "Jonathan", "pt": "Jônatas"},
				{"en": "Absalom", "pt": "Absalão"}
			]
		},
		{
			"question":
			{
				"en": "Which king asked God for wisdom instead of long life or riches?",
				"pt": "Qual rei pediu a Deus sabedoria em vez de longa vida ou riquezas?"
			},
			"answer": {"en": "Solomon", "pt": "Salomão"},
			"tier": 1,
			"decoys":
			[
				{"en": "Hezekiah", "pt": "Ezequias"},
				{"en": "Josiah", "pt": "Josias"},
				{"en": "Rehoboam", "pt": "Roboão"}
			]
		},
		{
			"question":
			{
				"en":
				"Which king of Judah had his life extended fifteen years after praying to God?",
				"pt": "Qual rei de Judá teve sua vida prolongada em quinze anos após orar a Deus?"
			},
			"answer": {"en": "Hezekiah", "pt": "Ezequias"},
			"tier": 2,
			"decoys":
			[
				{"en": "Asa", "pt": "Asa"},
				{"en": "Jehoshaphat", "pt": "Josafá"},
				{"en": "Uzziah", "pt": "Uzias"}
			]
		},
		{
			"question":
			{
				"en":
				"Which king of Judah rediscovered the Book of the Law and led a great Passover celebration?",
				"pt":
				"Qual rei de Judá redescobriu o Livro da Lei e conduziu uma grande celebração da Páscoa?"
			},
			"answer": {"en": "Josiah", "pt": "Josias"},
			"tier": 2,
			"decoys":
			[
				{"en": "Uzziah", "pt": "Uzias"},
				{"en": "Manasseh", "pt": "Manassés"},
				{"en": "Jehoram", "pt": "Jorão"}
			]
		},
		{
			"question":
			{
				"en":
				"Which king of Israel set up golden calves in Bethel and Dan, causing Israel to sin?",
				"pt":
				"Qual rei de Israel colocou bezerros de ouro em Betel e Dã, fazendo Israel pecar?"
			},
			"answer": {"en": "Jeroboam son of Nebat", "pt": "Jeroboão, filho de Nebate"},
			"tier": 2,
			"decoys":
			[
				{"en": "Ahab", "pt": "Acabe"},
				{"en": "Omri", "pt": "Onri"},
				{"en": "Jehu", "pt": "Jeú"}
			]
		},
		{
			"question":
			{
				"en":
				"Which king of Judah was struck with leprosy for burning incense in the temple, a duty reserved for priests?",
				"pt":
				"Qual rei de Judá foi acometido de lepra por queimar incenso no templo, tarefa reservada aos sacerdotes?"
			},
			"answer": {"en": "Uzziah (Azariah)", "pt": "Uzias (Azarias)"},
			"tier": 3,
			"decoys":
			[
				{"en": "Ahaz", "pt": "Acaz"},
				{"en": "Rehoboam", "pt": "Roboão"},
				{"en": "Jehoiakim", "pt": "Jeoaquim"}
			]
		},
		{
			"question":
			{
				"en":
				"Which last king of Judah saw his sons killed, had his eyes put out, and was taken to Babylon?",
				"pt":
				"Qual foi o último rei de Judá que viu seus filhos serem mortos, teve os olhos furados e foi levado para a Babilônia?"
			},
			"answer": {"en": "Zedekiah", "pt": "Zedequias"},
			"tier": 3,
			"decoys":
			[
				{"en": "Jehoiachin", "pt": "Jeoaquim"},
				{"en": "Manasseh", "pt": "Manassés"},
				{"en": "Ahaz", "pt": "Acaz"}
			]
		},
		{
			"question":
			{
				"en":
				"Which king of Israel bought the hill of Samaria and made it his capital city?",
				"pt": "Qual rei de Israel comprou o monte de Samaria e fez dele sua cidade capital?"
			},
			"answer": {"en": "Omri", "pt": "Onri"},
			"tier": 3,
			"decoys":
			[
				{"en": "Ahab", "pt": "Acabe"},
				{"en": "Jeroboam II", "pt": "Jeroboão II"},
				{"en": "Pekah", "pt": "Peca"}
			]
		},
		{
			"question":
			{
				"en": "Which king of Israel married Jezebel and promoted Baal worship in Israel?",
				"pt": "Qual rei de Israel se casou com Jezabel e promoveu o culto a Baal em Israel?"
			},
			"answer": {"en": "Ahab", "pt": "Acabe"},
			"tier": 2,
			"decoys":
			[
				{"en": "Jehu", "pt": "Jeú"},
				{"en": "Ahaziah", "pt": "Acazias"},
				{"en": "Hoshea", "pt": "Oséias (rei)"}
			]
		}
	],
	"Judges & Deliverers":
	[
		{
			"question":
			{
				"en":
				"Which judge defeated the Midianites with only three hundred men armed with trumpets and jars?",
				"pt":
				"Qual juiz derrotou os midianitas com apenas trezentos homens armados com trombetas e jarros?"
			},
			"answer": {"en": "Gideon", "pt": "Gideão"},
			"tier": 1,
			"decoys":
			[
				{"en": "Samson", "pt": "Sansão"},
				{"en": "Barak", "pt": "Baraque"},
				{"en": "Jephthah", "pt": "Jefté"}
			]
		},
		{
			"question":
			{
				"en": "Which judge was known for great strength and was betrayed by Delilah?",
				"pt": "Qual juiz era conhecido por sua grande força e foi traído por Dalila?"
			},
			"answer": {"en": "Samson", "pt": "Sansão"},
			"tier": 1,
			"decoys":
			[
				{"en": "Gideon", "pt": "Gideão"},
				{"en": "Othniel", "pt": "Otniel"},
				{"en": "Abimelech", "pt": "Abimeleque"}
			]
		},
		{
			"question":
			{
				"en":
				"Which woman judged Israel and sat under a palm tree while people came to her for decisions?",
				"pt":
				"Qual mulher julgou Israel e se sentava debaixo de uma palmeira enquanto o povo vinha a ela para decisões?"
			},
			"answer": {"en": "Deborah", "pt": "Débora"},
			"tier": 1,
			"decoys":
			[
				{"en": "Jael", "pt": "Jael"},
				{"en": "Hannah", "pt": "Ana"},
				{"en": "Ruth", "pt": "Rute"}
			]
		},
		{
			"question":
			{
				"en":
				"Which left-handed judge killed King Eglon of Moab with a double-edged sword?",
				"pt": "Qual juiz canhoto matou o rei Eglom de Moabe com uma espada de dois gumes?"
			},
			"answer": {"en": "Ehud", "pt": "Eúde"},
			"tier": 2,
			"decoys":
			[
				{"en": "Shamgar", "pt": "Samgar"},
				{"en": "Jephthah", "pt": "Jefté"},
				{"en": "Othniel", "pt": "Otniel"}
			]
		},
		{
			"question":
			{
				"en": "Which deliverer drove a tent peg through Sisera’s head while he slept?",
				"pt":
				"Qual libertadora atravessou a cabeça de Sísera com uma estaca de tenda enquanto ele dormia?"
			},
			"answer": {"en": "Jael", "pt": "Jael"},
			"tier": 2,
			"decoys":
			[
				{"en": "Deborah", "pt": "Débora"},
				{"en": "Delilah", "pt": "Dalila"},
				{"en": "Naomi", "pt": "Noemi"}
			]
		},
		{
			"question":
			{
				"en":
				"Which first judge of Israel delivered them from Cushan-Rishathaim king of Aram?",
				"pt": "Qual primeiro juiz de Israel os libertou de Cusã-Risataim, rei da Síria?"
			},
			"answer": {"en": "Othniel", "pt": "Otniel"},
			"tier": 2,
			"decoys":
			[
				{"en": "Ehud", "pt": "Eúde"},
				{"en": "Shamgar", "pt": "Samgar"},
				{"en": "Gideon", "pt": "Gideão"}
			]
		},
		{
			"question":
			{
				"en":
				"Which judge made a rash vow that resulted in great sorrow concerning his only child?",
				"pt":
				"Qual juiz fez um voto precipitado que resultou em grande tristeza em relação à sua única filha?"
			},
			"answer": {"en": "Jephthah", "pt": "Jefté"},
			"tier": 3,
			"decoys":
			[
				{"en": "Samson", "pt": "Sansão"},
				{"en": "Gideon", "pt": "Gideão"},
				{"en": "Abimelech", "pt": "Abimeleque"}
			]
		},
		{
			"question":
			{
				"en":
				"Which lesser-known judge had thirty sons who rode thirty donkeys and controlled thirty towns?",
				"pt":
				"Qual juiz menos conhecido teve trinta filhos que montavam trinta jumentos e governavam trinta cidades?"
			},
			"answer": {"en": "Jair", "pt": "Jair"},
			"tier": 3,
			"decoys":
			[
				{"en": "Ibzan", "pt": "Ibsã"},
				{"en": "Tola", "pt": "Tolá"},
				{"en": "Elon", "pt": "Elom"}
			]
		},
		{
			"question":
			{
				"en":
				"Which deliverer started out hiding in a winepress to thresh wheat because he feared the Midianites?",
				"pt":
				"Qual libertador começou escondido em um lagar para debulhar trigo porque temia os midianitas?"
			},
			"answer": {"en": "Gideon", "pt": "Gideão"},
			"tier": 2,
			"decoys":
			[
				{"en": "Samson", "pt": "Sansão"},
				{"en": "Barak", "pt": "Baraque"},
				{"en": "Saul", "pt": "Saul"}
			]
		},
		{
			"question":
			{
				"en":
				"Which judge tied torches between foxes’ tails to burn the Philistines’ fields?",
				"pt":
				"Qual juiz amarrou tochas entre as caudas de raposas para queimar os campos dos filisteus?"
			},
			"answer": {"en": "Samson", "pt": "Sansão"},
			"tier": 3,
			"decoys":
			[
				{"en": "Gideon", "pt": "Gideão"},
				{"en": "Shamgar", "pt": "Samgar"},
				{"en": "Jephthah", "pt": "Jefté"}
			]
		}
	],
	"Tabernacle & Temple":
	[
		{
			"question":
			{
				"en": "What was the portable sanctuary Israel used in the wilderness called?",
				"pt": "Como se chamava o santuário portátil que Israel usava no deserto?"
			},
			"answer": {"en": "The Tabernacle", "pt": "O Tabernáculo"},
			"tier": 1,
			"decoys":
			[
				{"en": "The Synagogue", "pt": "A Sinagoga"},
				{"en": "The Ark", "pt": "A Arca"},
				{"en": "The Tent of Saul", "pt": "A Tenda de Saul"}
			]
		},
		{
			"question":
			{
				"en": "Who built the first temple in Jerusalem?",
				"pt": "Quem construiu o primeiro templo em Jerusalém?"
			},
			"answer": {"en": "Solomon", "pt": "Salomão"},
			"tier": 1,
			"decoys":
			[
				{"en": "David", "pt": "Davi"},
				{"en": "Hezekiah", "pt": "Ezequias"},
				{"en": "Zerubbabel", "pt": "Zorobabel"}
			]
		},
		{
			"question":
			{
				"en":
				"What sacred chest was placed in the Most Holy Place with cherubim on its cover?",
				"pt": "Qual arca sagrada ficava no Santo dos Santos, com querubins sobre a tampa?"
			},
			"answer": {"en": "The Ark of the Covenant", "pt": "A Arca da Aliança"},
			"tier": 1,
			"decoys":
			[
				{"en": "The Bronze Altar", "pt": "O Altar de Bronze"},
				{"en": "The Incense Altar", "pt": "O Altar de Incenso"},
				{"en": "The Table of Bread", "pt": "A Mesa dos Pães"}
			]
		},
		{
			"question":
			{
				"en":
				"Who was filled with the Spirit of God in wisdom and skill to design the tabernacle?",
				"pt":
				"Quem foi cheio do Espírito de Deus em sabedoria e habilidade para projetar o tabernáculo?"
			},
			"answer": {"en": "Bezalel", "pt": "Bezalel"},
			"tier": 2,
			"decoys":
			[
				{"en": "Oholiab", "pt": "Aoliabe"},
				{"en": "Aaron", "pt": "Arão"},
				{"en": "Hur", "pt": "Hur"}
			]
		},
		{
			"question":
			{
				"en": "Which Levitical family carried the most holy furnishings of the tabernacle?",
				"pt": "Qual família levítica carregava os utensílios mais sagrados do tabernáculo?"
			},
			"answer": {"en": "The Kohathites", "pt": "Os coatitas"},
			"tier": 2,
			"decoys":
			[
				{"en": "The Gershonites", "pt": "Os gersonitas"},
				{"en": "The Merarites", "pt": "Os meraritas"},
				{"en": "The sons of Zadok", "pt": "Os filhos de Zadoque"}
			]
		},
		{
			"question":
			{
				"en": "What bronze item in the courtyard was used by priests for washing?",
				"pt": "Qual item de bronze no átrio era usado pelos sacerdotes para se lavarem?"
			},
			"answer": {"en": "The basin (laver)", "pt": "A bacia (lavatório)"},
			"tier": 2,
			"decoys":
			[
				{"en": "The lampstand", "pt": "O candelabro"},
				{"en": "The incense altar", "pt": "O altar de incenso"},
				{"en": "The table of showbread", "pt": "A mesa dos pães da proposição"}
			]
		},
		{
			"question":
			{
				"en": "What thick curtain was torn in two from top to bottom when Jesus died?",
				"pt":
				"Qual cortina espessa foi rasgada em duas, de alto a baixo, quando Jesus morreu?"
			},
			"answer": {"en": "The temple veil", "pt": "O véu do templo"},
			"tier": 1,
			"decoys":
			[
				{"en": "The outer gate", "pt": "O portão externo"},
				{"en": "The courtyard fence", "pt": "A cerca do átrio"},
				{"en": "The priestly garments", "pt": "As vestes sacerdotais"}
			]
		},
		{
			"question":
			{
				"en":
				"Which king of Judah reopened and cleansed the temple after his father had shut its doors?",
				"pt":
				"Qual rei de Judá reabriu e purificou o templo depois que seu pai havia fechado as portas?"
			},
			"answer": {"en": "Hezekiah", "pt": "Ezequias"},
			"tier": 3,
			"decoys":
			[
				{"en": "Ahaz", "pt": "Acaz"},
				{"en": "Manasseh", "pt": "Manassés"},
				{"en": "Josiah", "pt": "Josias"}
			]
		},
		{
			"question":
			{
				"en":
				"Who led the rebuilding of the temple after the exile when the foundation was laid again?",
				"pt":
				"Quem liderou a reconstrução do templo após o exílio, quando o fundamento foi novamente lançado?"
			},
			"answer": {"en": "Zerubbabel", "pt": "Zorobabel"},
			"tier": 3,
			"decoys":
			[
				{"en": "Nehemiah", "pt": "Neemias"},
				{"en": "Ezra", "pt": "Esdras"},
				{"en": "Joshua the high priest", "pt": "Josué, o sumo sacerdote"}
			]
		},
		{
			"question":
			{
				"en":
				"What piece of furniture in the Holy Place held twelve loaves representing the tribes of Israel?",
				"pt":
				"Qual móvel no Lugar Santo continha doze pães representando as tribos de Israel?"
			},
			"answer": {"en": "The table of showbread", "pt": "A mesa dos pães da proposição"},
			"tier": 2,
			"decoys":
			[
				{"en": "The bronze altar", "pt": "O altar de bronze"},
				{"en": "The lampstand", "pt": "O candelabro"},
				{"en": "The ark", "pt": "A arca"}
			]
		}
	],
	"Feasts & Festivals":
	[
		{
			"question":
			{
				"en":
				"Which feast remembers God passing over the houses marked with blood in Egypt?",
				"pt":
				"Qual festa lembra quando Deus passou por cima das casas marcadas com sangue no Egito?"
			},
			"answer": {"en": "Passover", "pt": "Páscoa"},
			"tier": 1,
			"decoys":
			[
				{"en": "Pentecost", "pt": "Pentecostes"},
				{"en": "Tabernacles", "pt": "Festa dos Tabernáculos"},
				{"en": "Purim", "pt": "Purim"}
			]
		},
		{
			"question":
			{
				"en":
				"Which feast took place fifty days after Passover and celebrated the firstfruits of the harvest?",
				"pt":
				"Qual festa ocorria cinquenta dias depois da Páscoa e celebrava os primeiros frutos da colheita?"
			},
			"answer": {"en": "Pentecost (Feast of Weeks)", "pt": "Pentecostes (Festa das Semanas)"},
			"tier": 1,
			"decoys":
			[
				{"en": "Trumpets", "pt": "Festa das Trombetas"},
				{"en": "Unleavened Bread", "pt": "Pães Asmos"},
				{"en": "Day of Atonement", "pt": "Dia da Expiação"}
			]
		},
		{
			"question":
			{
				"en":
				"Which feast involved living in booths to remember Israel’s time in the wilderness?",
				"pt":
				"Qual festa envolvia morar em tendas para lembrar o tempo de Israel no deserto?"
			},
			"answer": {"en": "Feast of Tabernacles (Booths)", "pt": "Festa dos Tabernáculos"},
			"tier": 1,
			"decoys":
			[
				{"en": "Feast of Trumpets", "pt": "Festa das Trombetas"},
				{"en": "Purim", "pt": "Purim"},
				{"en": "Hanukkah", "pt": "Hanukkah"}
			]
		},
		{
			"question":
			{
				"en":
				"On which solemn day did the high priest enter the Most Holy Place to make atonement for the nation?",
				"pt":
				"Em qual dia solene o sumo sacerdote entrava no Santo dos Santos para fazer expiação pela nação?"
			},
			"answer": {"en": "Day of Atonement (Yom Kippur)", "pt": "Dia da Expiação (Yom Kippur)"},
			"tier": 2,
			"decoys":
			[
				{"en": "Feast of Trumpets", "pt": "Festa das Trombetas"},
				{"en": "Passover", "pt": "Páscoa"},
				{"en": "Firstfruits", "pt": "Primícias"}
			]
		},
		{
			"question":
			{
				"en":
				"Which feast began with loud blasts on ram’s horns announcing a new year and repentance?",
				"pt":
				"Qual festa começava com toques altos de trombetas de chifre de carneiro, anunciando um novo ano e arrependimento?"
			},
			"answer": {"en": "Feast of Trumpets", "pt": "Festa das Trombetas"},
			"tier": 2,
			"decoys":
			[
				{"en": "Purim", "pt": "Purim"},
				{"en": "Passover", "pt": "Páscoa"},
				{"en": "Tabernacles", "pt": "Festa dos Tabernáculos"}
			]
		},
		{
			"question":
			{
				"en":
				"Which joyful feast in Esther’s time celebrated deliverance from Haman’s plot?",
				"pt": "Qual festa alegre no tempo de Ester celebrou a libertação do plano de Hamã?"
			},
			"answer": {"en": "Purim", "pt": "Purim"},
			"tier": 2,
			"decoys":
			[
				{"en": "Passover", "pt": "Páscoa"},
				{"en": "Hanukkah", "pt": "Hanukkah"},
				{"en": "Trumpets", "pt": "Festa das Trombetas"}
			]
		},
		{
			"question":
			{
				"en":
				"During which feast did Jesus stand and cry out about living water in John 7?",
				"pt": "Durante qual festa Jesus se levantou e clamou sobre a água viva em João 7?"
			},
			"answer": {"en": "Feast of Tabernacles", "pt": "Festa dos Tabernáculos"},
			"tier": 3,
			"decoys":
			[
				{"en": "Passover", "pt": "Páscoa"},
				{"en": "Pentecost", "pt": "Pentecostes"},
				{"en": "Trumpets", "pt": "Festa das Trombetas"}
			]
		},
		{
			"question":
			{
				"en":
				"Which feast do the Gospels connect with the Last Supper and Jesus as the Lamb of God?",
				"pt":
				"Qual festa os Evangelhos conectam com a Última Ceia e Jesus como o Cordeiro de Deus?"
			},
			"answer": {"en": "Passover", "pt": "Páscoa"},
			"tier": 2,
			"decoys":
			[
				{"en": "Purim", "pt": "Purim"},
				{"en": "Tabernacles", "pt": "Festa dos Tabernáculos"},
				{"en": "Pentecost", "pt": "Pentecostes"}
			]
		},
		{
			"question":
			{
				"en":
				"Which winter festival remembered the rededication of the temple in the days of the Maccabees?",
				"pt":
				"Qual festa de inverno lembrava a rededicação do templo nos dias dos Macabeus?"
			},
			"answer":
			{"en": "Hanukkah (Feast of Dedication)", "pt": "Hanukkah (Festa da Dedicação)"},
			"tier": 3,
			"decoys":
			[
				{"en": "Purim", "pt": "Purim"},
				{"en": "Trumpets", "pt": "Festa das Trombetas"},
				{"en": "Tabernacles", "pt": "Festa dos Tabernáculos"}
			]
		},
		{
			"question":
			{
				"en": "Which feast required removing all yeast from the houses for seven days?",
				"pt": "Qual festa exigia remover todo o fermento das casas por sete dias?"
			},
			"answer": {"en": "Feast of Unleavened Bread", "pt": "Festa dos Pães Asmos"},
			"tier": 2,
			"decoys":
			[
				{"en": "Feast of Weeks", "pt": "Festa das Semanas"},
				{"en": "Feast of Trumpets", "pt": "Festa das Trombetas"},
				{"en": "Day of Atonement", "pt": "Dia da Expiação"}
			]
		}
	],
	"Covenants & Promises":
	[
		{
			"question":
			{
				"en":
				"What sign did God give Noah as a reminder that He would never again flood the whole earth?",
				"pt":
				"Que sinal Deus deu a Noé como lembrança de que nunca mais inundaria toda a terra?"
			},
			"answer": {"en": "The rainbow", "pt": "O arco-íris"},
			"tier": 1,
			"decoys":
			[
				{"en": "The olive branch", "pt": "O ramo de oliveira"},
				{"en": "The burning bush", "pt": "A sarça ardente"},
				{"en": "The pillar of cloud", "pt": "A coluna de nuvem"}
			]
		},
		{
			"question":
			{
				"en":
				"What physical sign did God give Abraham’s descendants to mark His covenant with them?",
				"pt":
				"Que sinal físico Deus deu aos descendentes de Abraão para marcar a aliança com eles?"
			},
			"answer": {"en": "Circumcision", "pt": "A circuncisão"},
			"tier": 1,
			"decoys":
			[
				{"en": "Shaving the head", "pt": "Raspar a cabeça"},
				{"en": "Wearing tassels", "pt": "Usar franjas"},
				{"en": "Fasting yearly", "pt": "Jejuar todo ano"}
			]
		},
		{
			"question":
			{
				"en":
				"To whom did God promise, 'In your offspring all nations of the earth shall be blessed'?",
				"pt":
				"A quem Deus prometeu: 'Em tua descendência todas as nações da terra serão abençoadas'?"
			},
			"answer": {"en": "Abraham", "pt": "Abraão"},
			"tier": 1,
			"decoys":
			[
				{"en": "Noah", "pt": "Noé"},
				{"en": "Moses", "pt": "Moisés"},
				{"en": "David", "pt": "Davi"}
			]
		},
		{
			"question":
			{
				"en":
				"With whom did God make a covenant of law at Mount Sinai, including the Ten Commandments?",
				"pt":
				"Com quem Deus fez uma aliança de lei no Monte Sinai, incluindo os Dez Mandamentos?"
			},
			"answer": {"en": "Moses and Israel", "pt": "Moisés e Israel"},
			"tier": 2,
			"decoys":
			[
				{"en": "Joshua and Israel", "pt": "Josué e Israel"},
				{"en": "Samuel and Israel", "pt": "Samuel e Israel"},
				{"en": "David and Judah", "pt": "Davi e Judá"}
			]
		},
		{
			"question":
			{
				"en":
				"To which king did God promise an everlasting throne, ultimately fulfilled in Christ?",
				"pt":
				"A qual rei Deus prometeu um trono eterno, cumprido em última instância em Cristo?"
			},
			"answer": {"en": "David", "pt": "Davi"},
			"tier": 2,
			"decoys":
			[
				{"en": "Solomon", "pt": "Salomão"},
				{"en": "Saul", "pt": "Saul"},
				{"en": "Hezekiah", "pt": "Ezequias"}
			]
		},
		{
			"question":
			{
				"en":
				"Which prophet spoke of a new covenant where God would write His law on people’s hearts?",
				"pt":
				"Qual profeta falou de uma nova aliança em que Deus escreveria a Sua lei no coração das pessoas?"
			},
			"answer": {"en": "Jeremiah", "pt": "Jeremias"},
			"tier": 2,
			"decoys":
			[
				{"en": "Isaiah", "pt": "Isaías"},
				{"en": "Ezekiel", "pt": "Ezequiel"},
				{"en": "Hosea", "pt": "Oséias"}
			]
		},
		{
			"question":
			{
				"en": "Who was promised that he would not die until he had seen the Lord’s Christ?",
				"pt": "Quem recebeu a promessa de que não morreria antes de ver o Cristo do Senhor?"
			},
			"answer": {"en": "Simeon", "pt": "Simeão"},
			"tier": 3,
			"decoys":
			[
				{"en": "Zechariah", "pt": "Zacarias"},
				{"en": "John the Baptist", "pt": "João Batista"},
				{"en": "Anna", "pt": "Ana"}
			]
		},
		{
			"question":
			{
				"en":
				"Who received a promise that her barren womb would bear a son dedicated to the Lord all his life?",
				"pt":
				"Quem recebeu a promessa de que seu ventre estéril daria à luz um filho dedicado ao Senhor por toda a vida?"
			},
			"answer": {"en": "Hannah (mother of Samuel)", "pt": "Ana (mãe de Samuel)"},
			"tier": 2,
			"decoys":
			[
				{"en": "Elizabeth", "pt": "Isabel"},
				{"en": "Sarah", "pt": "Sara"},
				{"en": "Rachel", "pt": "Raquel"}
			]
		},
		{
			"question":
			{
				"en":
				"Which covenant did God seal with a meal on the mountain as Moses and elders ate before Him?",
				"pt":
				"Qual aliança Deus selou com uma refeição no monte, quando Moisés e os anciãos comeram diante dEle?"
			},
			"answer": {"en": "The Mosaic covenant at Sinai", "pt": "A aliança mosaica no Sinai"},
			"tier": 3,
			"decoys":
			[
				{"en": "The Abrahamic covenant", "pt": "A aliança abraâmica"},
				{"en": "The Noahic covenant", "pt": "A aliança com Noé"},
				{"en": "The Davidic covenant", "pt": "A aliança davídica"}
			]
		},
		{
			"question":
			{
				"en": "At the Last Supper, what did Jesus call 'the new covenant in my blood'?",
				"pt": "Na Última Ceia, o que Jesus chamou de 'a nova aliança no meu sangue'?"
			},
			"answer": {"en": "The cup", "pt": "O cálice"},
			"tier": 2,
			"decoys":
			[
				{"en": "The bread", "pt": "O pão"},
				{"en": "The basin", "pt": "A bacia"},
				{"en": "The towel", "pt": "A toalha"}
			]
		}
	],
}

static var CATEGORIES: Array = []
static var CURRENT_LANGUAGE: String = "en"


static func set_language(lang: String) -> void:
	var normalized := lang.to_lower()
	if normalized == CURRENT_LANGUAGE:
		return
	CURRENT_LANGUAGE = normalized
	CATEGORIES.clear()


static func _localized_text(value, lang: String) -> String:
	if value is Dictionary:
		var dict := value as Dictionary
		var chosen := str(dict.get(lang, dict.get("en", "")))
		if chosen.strip_edges() != "":
			return chosen
		if not dict.is_empty():
			for v in dict.values():
				var s := str(v)
				if s.strip_edges() != "":
					return s
	return str(value)


static func _category_base_key(value) -> String:
	if value is Dictionary:
		var dict := value as Dictionary
		if dict.has("id"):
			return str(dict["id"])
		if dict.has("en"):
			return str(dict["en"])
		if dict.has("pt"):
			return str(dict["pt"])
	return str(value)


static func _qa_key(qa: Dictionary) -> String:
	var raw: String = str(qa.get("question", ""))
	return _localized_text(raw, "en").strip_edges().to_lower()


static func _normalize_qa_language(qa: Dictionary, lang: String) -> Dictionary:
	var copy := qa.duplicate(true)
	copy["question"] = _localized_text(copy.get("question", ""), lang)
	copy["answer"] = _localized_text(copy.get("answer", ""), lang)
	var decoys: Array[String] = []
	if copy.has("decoys"):
		for d in copy["decoys"] as Array:
			decoys.append(_localized_text(d, lang))
	copy["decoys"] = decoys
	return copy


static func _prepare_base_list(base_list: Array, lang: String) -> Array:
	var prepared: Array = []
	for i in range(base_list.size()):
		var qa: Dictionary = _normalize_qa_language(base_list[i] as Dictionary, lang)
		if not qa.has("tier"):
			qa["tier"] = 1 + (i % 3)
		prepared.append(qa)
	return prepared


static func _build_categories() -> Array:
	var categories: Array = []
	var tier_order: Array[int] = [1, 2, 3]
	for idx in CATEGORY_NAMES.size():
		var cat_entry = CATEGORY_NAMES[idx]
		var cat_key: String = _category_base_key(cat_entry)
		var cat_name: String = _localized_text(cat_entry, CURRENT_LANGUAGE)
		var base_list: Array = _prepare_base_list(BASE_QA.get(cat_key, []), CURRENT_LANGUAGE)
		if base_list.is_empty():
			continue

		var tier_buckets := {1: [], 2: [], 3: []}
		var used_questions := {}
		for qa in base_list:
			var t: int = int((qa as Dictionary).get("tier", 1))
			t = clamp(t, 1, 3)
			(tier_buckets[t] as Array).append(qa)

		var pool_size_per_value: int = (
			LARGE_POOL_COUNT if idx < LARGE_POOL_CATEGORIES else SMALL_POOL_COUNT
		)
		var values: Array = []
		for v_idx in VALUES.size():
			var value := VALUES[v_idx]
			var target_tier: int = tier_order[v_idx % tier_order.size()]
			var source: Array = tier_buckets.get(target_tier, [])
			if source.is_empty():
				for alt in tier_order:
					if not (tier_buckets[alt] as Array).is_empty():
						source = tier_buckets[alt]
						break
			var pool: Array = []
			var candidates: Array = []
			if not source.is_empty():
				candidates = source.duplicate(true)
			else:
				candidates = base_list.duplicate(true)
			candidates.shuffle()
			for qa_raw in candidates:
				if pool.size() >= pool_size_per_value:
					break
				var qa_dict := qa_raw as Dictionary
				var key := _qa_key(qa_dict)
				if used_questions.has(key):
					continue
				pool.append(qa_dict.duplicate(true))
				used_questions[key] = true
			if pool.size() < pool_size_per_value:
				var fallback: Array = base_list.duplicate(true)
				fallback.shuffle()
				for qa_raw in fallback:
					if pool.size() >= pool_size_per_value:
						break
					var qa_dict := qa_raw as Dictionary
					pool.append(qa_dict.duplicate(true))
					used_questions[_qa_key(qa_dict)] = true
			values.append({"value": value, "pool": pool})
		categories.append({"key": cat_key, "name": cat_name, "values": values})
	return categories


static func get_categories(limit: int = -1) -> Array:
	if CATEGORIES.is_empty():
		CATEGORIES = _build_categories()
	var shuffled := CATEGORIES.duplicate(true)
	shuffled.shuffle()
	if limit > -1:
		var capped: int = min(limit, shuffled.size())
		var limited: Array = []
		for i in range(capped):
			limited.append(shuffled[i])
		return limited
	return shuffled


static func get_localized_text(value, lang: String) -> String:
	return _localized_text(value, lang)


static func get_localized_qa(qa: Dictionary, lang: String = "en") -> Dictionary:
	return _normalize_qa_language(qa, lang)


static func get_category_index_by_en_name(en_name: String) -> int:
	for i in CATEGORY_NAMES.size():
		var entry = CATEGORY_NAMES[i]
		if entry is Dictionary and (entry as Dictionary).get("en", "") == en_name:
			return i
		if str(entry) == en_name:
			return i
	return -1
