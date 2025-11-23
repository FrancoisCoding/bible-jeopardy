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
	{"en": "Heroes of Faith (Hebrews 11)", "pt": "Heróis da Fé (Hebreus 11)"}
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
			"tier": 2,
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
			"tier": 2,
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
			"tier": 2,
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
			"tier": 1,
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
			"tier": 1,
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
			"tier": 1,
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
			"tier": 1,
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
			"tier": 1,
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
			"tier": 1,
			"decoys":
			[
				{"en": "The Dead Sea", "pt": "O Mar Morto"},
				{"en": "The Mediterranean", "pt": "O Mediterrâneo"},
				{"en": "The Nile", "pt": "O Nilo"}
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
			"tier": 2,
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
			"tier": 2,
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
			"tier": 2,
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
			"tier": 2,
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
			"tier": 1,
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
			"tier": 1,
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
			"tier": 1,
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
			"tier": 1,
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
			"tier": 2,
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
			"tier": 2,
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
			"tier": 2,
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
			"tier": 2,
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
			"tier": 2,
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
			"tier": 2,
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
				{"en": "Naomi", "pt": "Noemi"},
				{"en": "Esther", "pt": "Ester"},
				{"en": "Deborah", "pt": "Débora"}
			]
		},
		{
			"question":
			{
				"en": "Which queen saved her people from Haman?",
				"pt": "Qual rainha salvou seu povo de Hamã?"
			},
			"answer": {"en": "Esther", "pt": "Ester"},
			"tier": 1,
			"decoys":
			[
				{"en": "Vashti", "pt": "Vasti"},
				{"en": "Jezebel", "pt": "Jezabel"},
				{"en": "Athaliah", "pt": "Atalia"}
			]
		},
		{
			"question":
			{
				"en": "Who judged Israel under the palm tree?",
				"pt": "Quem julgou Israel debaixo da palmeira?"
			},
			"answer": {"en": "Deborah", "pt": "Débora"},
			"tier": 2,
			"decoys":
			[
				{"en": "Huldah", "pt": "Hulda"},
				{"en": "Jael", "pt": "Jael"},
				{"en": "Miriam", "pt": "Míriam"}
			]
		},
		{
			"question":
			{
				"en": "Who prayed for a son and bore Samuel?",
				"pt": "Quem orou por um filho e deu à luz Samuel?"
			},
			"answer": {"en": "Hannah", "pt": "Ana"},
			"tier": 1,
			"decoys":
			[
				{"en": "Elizabeth", "pt": "Elisabete"},
				{"en": "Sarah", "pt": "Sara"},
				{"en": "Rachel", "pt": "Raquel"}
			]
		},
		{
			"question": {"en": "Who was Abraham's wife?", "pt": "Quem era a esposa de Abraão?"},
			"answer": {"en": "Sarah", "pt": "Sara"},
			"tier": 1,
			"decoys":
			[
				{"en": "Rebekah", "pt": "Rebeca"},
				{"en": "Rachel", "pt": "Raquel"},
				{"en": "Leah", "pt": "Lia"}
			]
		},
		{
			"question":
			{"en": "Who killed Sisera with a tent peg?", "pt": "Quem matou Sísera com uma estaca?"},
			"answer": {"en": "Jael", "pt": "Jael"},
			"tier": 2,
			"decoys":
			[
				{"en": "Deborah", "pt": "Débora"},
				{"en": "Miriam", "pt": "Míriam"},
				{"en": "Athaliah", "pt": "Atalia"}
			]
		},
		{
			"question":
			{
				"en": "Who hid the Hebrew spies on her roof?",
				"pt": "Quem escondeu os espiões hebreus no telhado dela?"
			},
			"answer": {"en": "Rahab", "pt": "Raabe"},
			"tier": 1,
			"decoys":
			[
				{"en": "Ruth", "pt": "Rute"},
				{"en": "Miriam", "pt": "Míriam"},
				{"en": "Leah", "pt": "Lia"}
			]
		},
		{
			"question":
			{
				"en": "Who was Lot's wife turned into a pillar of salt?",
				"pt": "Quem foi a esposa de Ló transformada em estátua de sal?"
			},
			"answer": {"en": "Lot's wife", "pt": "A esposa de Ló"},
			"tier": 1,
			"decoys":
			[
				{"en": "Naomi", "pt": "Noemi"},
				{"en": "Tamar", "pt": "Tamar"},
				{"en": "Zipporah", "pt": "Zípora"}
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
			{"en": "Who was Jacob's first wife?", "pt": "Quem foi a primeira esposa de Jacó?"},
			"answer": {"en": "Leah", "pt": "Lia"},
			"tier": 1,
			"decoys":
			[
				{"en": "Rachel", "pt": "Raquel"},
				{"en": "Bilhah", "pt": "Bilá"},
				{"en": "Zilpah", "pt": "Zilpa"}
			]
		},
		{
			"question":
			{
				"en": "Who anointed Jesus' feet with costly perfume (OT foreshadow)?",
				"pt": "Quem ungiu os pés de Jesus com perfume caro (prefiguração do AT)?"
			},
			"answer": {"en": "Not in OT", "pt": "Não no AT"},
			"tier": 3,
			"decoys":
			[
				{"en": "Esther", "pt": "Ester"},
				{"en": "Hannah", "pt": "Ana"},
				{"en": "Miriam", "pt": "Míriam"}
			]
		},
		{
			"question":
			{
				"en": "Who urged Elisha to stay with her family and built him a room?",
				"pt": "Quem incentivou Eliseu a ficar com a família e construiu um quarto para ele?"
			},
			"answer": {"en": "The Shunammite woman", "pt": "A mulher Sunamita"},
			"tier": 2,
			"decoys":
			[
				{"en": "The widow of Zarephath", "pt": "A viúva de Sarepta"},
				{"en": "Hannah", "pt": "Ana"},
				{"en": "Abigail", "pt": "Abigail"}
			]
		},
		{
			"question":
			{
				"en": "Who married Boaz and became David's great-grandmother?",
				"pt": "Quem se casou com Boaz e se tornou bisavó de Davi?"
			},
			"answer": {"en": "Ruth", "pt": "Rute"},
			"tier": 1,
			"decoys":
			[
				{"en": "Naomi", "pt": "Noemi"},
				{"en": "Orpah", "pt": "Orfa"},
				{"en": "Tamar", "pt": "Tamar"}
			]
		},
		{
			"question":
			{
				"en": "Who confronted David for wanting Nabal's food?",
				"pt": "Quem confrontou Davi por querer a comida de Nabal?"
			},
			"answer": {"en": "Abigail", "pt": "Abigail"},
			"tier": 2,
			"decoys":
			[
				{"en": "Michal", "pt": "Mical"},
				{"en": "Bathsheba", "pt": "Bate-Seba"},
				{"en": "Ahinoam", "pt": "Ainoã"}
			]
		},
		{
			"question":
			{
				"en": "Who was the prophetess that found the Book of the Law in Josiah's time?",
				"pt": "Quem foi a profetisa que encontrou o Livro da Lei na época de Josias?"
			},
			"answer": {"en": "Huldah", "pt": "Hulda"},
			"tier": 2,
			"decoys":
			[
				{"en": "Deborah", "pt": "Débora"},
				{"en": "Miriam", "pt": "Míriam"},
				{"en": "Anna", "pt": "Ana"}
			]
		},
		{
			"question": {"en": "Who was the mother of Samson?", "pt": "Quem foi a mãe de Sansão?"},
			"answer": {"en": "Manoah's wife", "pt": "A esposa de Manoá"},
			"tier": 2,
			"decoys":
			[
				{"en": "Hannah", "pt": "Ana"},
				{"en": "Naomi", "pt": "Noemi"},
				{"en": "Bathsheba", "pt": "Bate-Seba"}
			]
		},
		{
			"question": {"en": "Who was mother of Samuel?", "pt": "Quem foi a mãe de Samuel?"},
			"answer": {"en": "Hannah", "pt": "Ana"},
			"tier": 1,
			"decoys":
			[
				{"en": "Elizabeth", "pt": "Elisabete"},
				{"en": "Miriam", "pt": "Míriam"},
				{"en": "Deborah", "pt": "Débora"}
			]
		},
		{
			"question":
			{"en": "Who rescued Moses as a baby?", "pt": "Quem resgatou Moisés quando bebê?"},
			"answer": {"en": "Pharaoh's daughter", "pt": "Filha do Faraó"},
			"tier": 1,
			"decoys":
			[
				{"en": "Miriam", "pt": "Míriam"},
				{"en": "Jochebed", "pt": "Joquebede"},
				{"en": "Zipporah", "pt": "Zípora"}
			]
		},
		{
			"question":
			{
				"en": "Who was mother of John the Baptist (OT segue)?",
				"pt": "Quem foi a mãe de João Batista (OT segue)?"
			},
			"answer": {"en": "Elizabeth", "pt": "Elisabete"},
			"tier": 3,
			"decoys":
			[
				{"en": "Hannah", "pt": "Ana"},
				{"en": "Sarah", "pt": "Sara"},
				{"en": "Miriam", "pt": "Míriam"}
			]
		},
		{
			"question":
			{
				"en": "Who was King Ahab's wicked wife?",
				"pt": "Quem era a esposa perversa do rei Acabe?"
			},
			"answer": {"en": "Jezebel", "pt": "Jezabel"},
			"tier": 1,
			"decoys":
			[
				{"en": "Athaliah", "pt": "Atalia"},
				{"en": "Vashti", "pt": "Vasti"},
				{"en": "Delilah", "pt": "Dalila"}
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
			"tier": 2,
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
			"tier": 2,
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
			"tier": 2,
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
		}
	],
	"Birth of Jesus":
	[
		{
			"question": {"en": "Where was Jesus born?", "pt": "Onde Jesus nasceu?"},
			"answer": {"en": "Bethlehem", "pt": "Belém"},
			"tier": 1,
			"decoys":
			[
				{"en": "Nazareth", "pt": "Nazaré"},
				{"en": "Jerusalem", "pt": "Jerusalém"},
				{"en": "Capernaum", "pt": "Cafarnaum"}
			]
		},
		{
			"question": {"en": "Who was Jesus' mother?", "pt": "Quem foi a mãe de Jesus?"},
			"answer": {"en": "Mary", "pt": "Mary"},
			"tier": 1,
			"decoys":
			[
				{"en": "Elizabeth", "pt": "Elisabete"},
				{"en": "Martha", "pt": "Marta"},
				{"en": "Salome", "pt": "Salomé"}
			]
		},
		{
			"question":
			{
				"en": "Where was Jesus laid after birth?",
				"pt": "Onde Jesus foi colocado após o nascimento?"
			},
			"answer": {"en": "In a manger", "pt": "Em uma manjedoura"},
			"tier": 1,
			"decoys":
			[
				{"en": "In a crib", "pt": "Em um berço"},
				{"en": "In a basket", "pt": "Em uma cesta"},
				{"en": "On straw in a cave", "pt": "Na palha em uma caverna"}
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
				{"en": "Wise men", "pt": "Homens sábios"},
				{"en": "Priests", "pt": "Sacerdotes"},
				{"en": "Prophets", "pt": "Profetas"}
			]
		},
		{
			"question":
			{
				"en": "Who was Jesus' earthly guardian from the house of David?",
				"pt": "Quem foi o guardião terrestre de Jesus na casa de Davi?"
			},
			"answer": {"en": "Joseph the carpenter", "pt": "José, o carpinteiro"},
			"tier": 1,
			"decoys":
			[
				{"en": "Zacharias", "pt": "Zacarias"},
				{"en": "Simeon", "pt": "Simeão"},
				{"en": "Nicodemus", "pt": "Nicodemos"}
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
				"en": "A baby wrapped in cloths lying in a manger",
				"pt": "Um bebê envolto em panos deitado numa manjedoura"
			},
			"tier": 2,
			"decoys":
			[
				{"en": "A star over a house", "pt": "Uma estrela sobre uma casa"},
				{"en": "A crown on a child", "pt": "Uma coroa em uma criança"},
				{"en": "A lamb by the child", "pt": "Um cordeiro da criança"}
			]
		},
		{
			"question":
			{
				"en": "Who decreed the census that brought Mary and Joseph to Bethlehem?",
				"pt": "Quem decretou o censo que trouxe Maria e José a Belém?"
			},
			"answer": {"en": "Caesar Augustus", "pt": "César Augusto"},
			"tier": 2,
			"decoys":
			[
				{"en": "Herod", "pt": "Herodes"},
				{"en": "Quirinius", "pt": "Quirino"},
				{"en": "Tiberius", "pt": "Tibério"}
			]
		},
		{
			"question":
			{
				"en": "Who visited Jesus guided by a star?",
				"pt": "Quem visitou Jesus guiado por uma estrela?"
			},
			"answer": {"en": "Wise men from the east", "pt": "Homens sábios do leste"},
			"tier": 1,
			"decoys":
			[
				{"en": "Shepherds from Judea", "pt": "Pastores da Judéia"},
				{"en": "Priests from Jerusalem", "pt": "Sacerdotes de Jerusalém"},
				{"en": "Merchants from Damascus", "pt": "Comerciantes de Damasco"}
			]
		},
		{
			"question":
			{
				"en": "What gifts did the wise men bring?",
				"pt": "Que presentes os sábios trouxeram?"
			},
			"answer": {"en": "Gold, frankincense, and myrrh", "pt": "Ouro, incenso e mirra"},
			"tier": 1,
			"decoys":
			[
				{"en": "Jewels, spices, and silk", "pt": "Joias, especiarias e seda"},
				{"en": "Silver, incense, and oil", "pt": "Prata, incenso e óleo"},
				{"en": "Bronze, balsam, and wine", "pt": "Bronze, bálsamo e vinho"}
			]
		},
		{
			"question":
			{
				"en": "Where did the family flee from Herod?",
				"pt": "Para onde a família fugiu de Herodes?"
			},
			"answer": {"en": "Egypt", "pt": "Egito"},
			"tier": 1,
			"decoys":
			[
				{"en": "Nazareth", "pt": "Nazaré"},
				{"en": "Damascus", "pt": "Damasco"},
				{"en": "Babylon", "pt": "Babilônia"}
			]
		},
		{
			"question":
			{
				"en": "Who prophesied over baby Jesus saying 'a sword will pierce your soul'?",
				"pt":
				"Quem profetizou sobre o menino Jesus dizendo 'uma espada traspassará sua alma'?"
			},
			"answer": {"en": "Simeon", "pt": "Simeão"},
			"tier": 2,
			"decoys":
			[
				{"en": "Zechariah", "pt": "Zacarias"},
				{"en": "Anna", "pt": "Ana"},
				{"en": "Caiaphas", "pt": "Caifás"}
			]
		},
		{
			"question":
			{
				"en": "Who was the prophetess that rejoiced in the temple at Jesus' presentation?",
				"pt": "Quem foi a profetisa que se alegrou no templo com a apresentação de Jesus?"
			},
			"answer": {"en": "Anna", "pt": "Ana"},
			"tier": 2,
			"decoys":
			[
				{"en": "Elizabeth", "pt": "Elisabete"},
				{"en": "Mary of Clopas", "pt": "Maria de Clopas"},
				{"en": "Martha", "pt": "Marta"}
			]
		},
		{
			"question":
			{"en": "What town did Jesus grow up in?", "pt": "Em que cidade Jesus cresceu?"},
			"answer": {"en": "Nazareth", "pt": "Nazaré"},
			"tier": 1,
			"decoys":
			[
				{"en": "Bethlehem", "pt": "Belém"},
				{"en": "Cana", "pt": "Caná"},
				{"en": "Capernaum", "pt": "Cafarnaum"}
			]
		},
		{
			"question": {"en": "What lineage was Joseph from?", "pt": "De que linhagem era José?"},
			"answer": {"en": "David", "pt": "Davi"},
			"tier": 1,
			"decoys":
			[
				{"en": "Levi", "pt": "Levi"},
				{"en": "Benjamin", "pt": "Benjamin"},
				{"en": "Judah", "pt": "Judá"}
			]
		},
		{
			"question":
			{
				"en": "What was Mary's relative Elizabeth known for?",
				"pt": "Pelo que Elizabeth, parente de Maria, era conhecida?"
			},
			"answer": {"en": "Mother of John the Baptist", "pt": "Mãe de João Batista"},
			"tier": 2,
			"decoys":
			[
				{"en": "Prophetess in the temple", "pt": "Profetisa no templo"},
				{"en": "Daughter of Aaron", "pt": "Filha de Arão"},
				{"en": "Sister of Martha", "pt": "Irmã de Marta"}
			]
		},
		{
			"question":
			{
				"en": "Who ordered the massacre of infants in Bethlehem?",
				"pt": "Quem ordenou o massacre de crianças em Belém?"
			},
			"answer": {"en": "Herod", "pt": "Herodes"},
			"tier": 1,
			"decoys":
			[
				{"en": "Pilate", "pt": "Pilatos"},
				{"en": "Caiaphas", "pt": "Caifás"},
				{"en": "Augustus", "pt": "Augusto"}
			]
		},
		{
			"question":
			{
				"en": "Where was the angel Gabriel sent to announce to Mary?",
				"pt": "Onde foi enviado o anjo Gabriel para anunciar a Maria?"
			},
			"answer": {"en": "Nazareth", "pt": "Nazaré"},
			"tier": 2,
			"decoys":
			[
				{"en": "Bethlehem", "pt": "Belém"},
				{"en": "Jerusalem", "pt": "Jerusalém"},
				{"en": "Hebron", "pt": "Hebrom"}
			]
		},
		{
			"question":
			{
				"en": "What did the shepherds do after seeing Jesus?",
				"pt": "O que os pastores fizeram depois de ver Jesus?"
			},
			"answer":
			{
				"en": "Spread the word and glorified God",
				"pt": "Espalhe a palavra e glorifique a Deus"
			},
			"tier": 2,
			"decoys":
			[
				{"en": "Returned silently", "pt": "Retornou silenciosamente"},
				{"en": "Told only priests", "pt": "Disse apenas aos padres"},
				{"en": "Stayed in Bethlehem", "pt": "Fiquei em Belém"}
			]
		},
		{
			"question": {"en": "Who was Mary's husband?", "pt": "Quem era o marido de Maria?"},
			"answer": {"en": "Joseph", "pt": "José"},
			"tier": 1,
			"decoys":
			[
				{"en": "Zechariah", "pt": "Zacarias"},
				{"en": "John", "pt": "John"},
				{"en": "Simon", "pt": "Simão"}
			]
		},
		{
			"question":
			{
				"en": "What name was given because He will save His people?",
				"pt": "Que nome foi dado porque Ele salvará Seu povo?"
			},
			"answer": {"en": "Jesus", "pt": "Jesus"},
			"tier": 1,
			"decoys":
			[
				{"en": "Emmanuel", "pt": "Emanuel"},
				{"en": "Christ", "pt": "Cristo"},
				{"en": "Messiah", "pt": "messias"}
			]
		}
	],
	"Miracles of Jesus":
	[
		{
			"question":
			{
				"en": "What did Jesus turn water into at Cana?",
				"pt": "Em que Jesus transformou a água em Caná?"
			},
			"answer": {"en": "Wine", "pt": "Vinho"},
			"tier": 1,
			"decoys":
			[
				{"en": "Oil", "pt": "Óleo"},
				{"en": "Milk", "pt": "Leite"},
				{"en": "Vinegar", "pt": "Vinagre"}
			]
		},
		{
			"question":
			{
				"en": "How many were fed with five loaves and two fish?",
				"pt": "Quantos foram alimentados com cinco pães e dois peixes?"
			},
			"answer": {"en": "About five thousand men", "pt": "Cerca de cinco mil homens"},
			"tier": 2,
			"decoys":
			[
				{"en": "About four thousand", "pt": "Cerca de quatro mil"},
				{"en": "About six thousand", "pt": "Cerca de seis mil"},
				{"en": "About three thousand", "pt": "Cerca de três mil"}
			]
		},
		{
			"question":
			{
				"en": "Who did Jesus call out of the tomb after four days?",
				"pt": "Quem Jesus chamou para fora do túmulo depois de quatro dias?"
			},
			"answer": {"en": "Lazarus", "pt": "Lázaro"},
			"tier": 1,
			"decoys":
			[
				{"en": "Jairus' daughter", "pt": "filha de Jairo"},
				{"en": "Widow's son at Nain", "pt": "Filho da viúva em Naim"},
				{"en": "Tabitha", "pt": "Tabita"}
			]
		},
		{
			"question":
			{"en": "What stormy sea did Jesus calm?", "pt": "Que mar tempestuoso Jesus acalmou?"},
			"answer": {"en": "The Sea of Galilee", "pt": "O Mar da Galileia"},
			"tier": 1,
			"decoys":
			[
				{"en": "The Dead Sea", "pt": "O Mar Morto"},
				{"en": "The Red Sea", "pt": "O Mar Vermelho"},
				{"en": "The Mediterranean", "pt": "O Mediterrâneo"}
			]
		},
		{
			"question":
			{
				"en": "On what did Jesus walk to reach his disciples?",
				"pt": "Sobre o que Jesus caminhou para alcançar seus discípulos?"
			},
			"answer": {"en": "On the water", "pt": "Na água"},
			"tier": 1,
			"decoys":
			[
				{"en": "On the shore", "pt": "Na costa"},
				{"en": "On a boat", "pt": "Em um barco"},
				{"en": "On a path", "pt": "Em um caminho"}
			]
		},
		{
			"question":
			{
				"en": "Whose daughter did Jesus raise saying 'Talitha koum'?",
				"pt": "De quem é a filha que Jesus criou dizendo 'Talitha koum'?"
			},
			"answer": {"en": "Jairus' daughter", "pt": "filha de Jairo"},
			"tier": 2,
			"decoys":
			[
				{"en": "Widow's son at Nain", "pt": "Filho da viúva em Naim"},
				{"en": "Lazarus", "pt": "Lázaro"},
				{"en": "Peter's mother-in-law", "pt": "A sogra de Pedro"}
			]
		},
		{
			"question":
			{
				"en": "Who was healed after touching the edge of Jesus' cloak?",
				"pt": "Quem foi curado depois de tocar na orla do manto de Jesus?"
			},
			"answer":
			{"en": "The woman with the issue of blood", "pt": "A mulher com problema de sangue"},
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
				"en": "How many lepers did Jesus cleanse at once on the way to Jerusalem?",
				"pt": "Quantos leprosos Jesus purificou de uma só vez no caminho para Jerusalém?"
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
				"en": "What food did Jesus multiply to feed four thousand?",
				"pt": "Que comida Jesus multiplicou para alimentar quatro mil?"
			},
			"answer": {"en": "Seven loaves and a few fish", "pt": "Sete pães e alguns peixes"},
			"tier": 2,
			"decoys":
			[
				{"en": "Five loaves and two fish", "pt": "Cinco pães e dois peixes"},
				{"en": "Two loaves and five fish", "pt": "Dois pães e cinco peixes"},
				{"en": "Five barley cakes and goats", "pt": "Cinco bolos de cevada e cabras"}
			]
		},
		{
			"question":
			{
				"en": "What filled Peter's nets when Jesus called him by the lake?",
				"pt": "O que encheu as redes de Pedro quando Jesus o chamou à beira do lago?"
			},
			"answer": {"en": "A miraculous catch of fish", "pt": "Uma pesca milagrosa"},
			"tier": 1,
			"decoys":
			[
				{"en": "Baskets of bread", "pt": "Cestas de pão"},
				{"en": "A school of turtles", "pt": "Uma escola de tartarugas"},
				{"en": "A swarm of locusts", "pt": "Um enxame de gafanhotos"}
			]
		},
		{
			"question":
			{
				"en": "Where did Jesus send demons into a herd of pigs?",
				"pt": "Para onde Jesus enviou demônios para uma manada de porcos?"
			},
			"answer": {"en": "The region of the Gerasenes", "pt": "A região dos gerasenos"},
			"tier": 2,
			"decoys":
			[
				{"en": "Bethsaida", "pt": "Betsaida"},
				{"en": "Capernaum", "pt": "Cafarnaum"},
				{"en": "Jericho", "pt": "Jericó"}
			]
		},
		{
			"question":
			{
				"en": "What tree did Jesus curse so it withered?",
				"pt": "Que árvore Jesus amaldiçoou e por isso secou?"
			},
			"answer": {"en": "A fig tree", "pt": "Uma figueira"},
			"tier": 1,
			"decoys":
			[
				{"en": "An olive tree", "pt": "Uma oliveira"},
				{"en": "A cedar tree", "pt": "Uma árvore de cedro"},
				{"en": "A sycamore tree", "pt": "Uma árvore de sicômoro"}
			]
		},
		{
			"question":
			{
				"en": "What happened to Peter's mother-in-law when Jesus touched her hand?",
				"pt": "O que aconteceu com a sogra de Pedro quando Jesus tocou sua mão?"
			},
			"answer": {"en": "Her fever left her", "pt": "Sua febre a deixou"},
			"tier": 1,
			"decoys":
			[
				{"en": "She was raised from the dead", "pt": "Ela foi ressuscitada dos mortos"},
				{"en": "She was struck mute", "pt": "Ela ficou muda"},
				{"en": "She went blind", "pt": "Ela ficou cega"}
			]
		},
		{
			"question":
			{
				"en": "Who was raised from the dead at the town of Nain?",
				"pt": "Quem foi ressuscitado dos mortos na cidade de Naim?"
			},
			"answer": {"en": "A widow's son", "pt": "Filho de uma viúva"},
			"tier": 2,
			"decoys":
			[
				{"en": "A centurion's servant", "pt": "Servo de um centurião"},
				{"en": "Jairus' daughter", "pt": "filha de Jairo"},
				{"en": "Tabitha", "pt": "Tabita"}
			]
		},
		{
			"question":
			{
				"en": "What did Jesus tell Peter to find in a fish's mouth?",
				"pt": "O que Jesus disse a Pedro para encontrar na boca de um peixe?"
			},
			"answer":
			{"en": "A coin for the temple tax", "pt": "Uma moeda para o imposto do templo"},
			"tier": 2,
			"decoys":
			[
				{"en": "A pearl of great price", "pt": "Uma pérola de ótimo preço"},
				{"en": "A ring for Mary", "pt": "Um anel para Maria"},
				{"en": "A scroll fragment", "pt": "Um fragmento de pergaminho"}
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
				{"en": "James", "pt": "James"},
				{"en": "Andrew", "pt": "André"}
			]
		},
		{
			"question":
			{
				"en": "Who was born blind and healed after washing in Siloam?",
				"pt": "Quem nasceu cego e foi curado após lavar-se em Siloé?"
			},
			"answer":
			{"en": "The man born blind in John 9", "pt": "O homem que nasceu cego em João 9"},
			"tier": 2,
			"decoys":
			[
				{"en": "Bartimaeus", "pt": "Bartimeu"},
				{"en": "Ten lepers", "pt": "Dez leprosos"},
				{"en": "The servant of Malchus", "pt": "O servo de Malco"}
			]
		},
		{
			"question":
			{
				"en": "Whose servant was healed from a distance because of faith?",
				"pt": "Qual servo foi curado à distância por causa da fé?"
			},
			"answer": {"en": "The centurion's servant", "pt": "O servo do centurião"},
			"tier": 2,
			"decoys":
			[
				{"en": "Jairus' servant", "pt": "Servo de Jairo"},
				{"en": "Herod's officer", "pt": "Oficial de Herodes"},
				{"en": "A synagogue ruler's slave", "pt": "Escravo do governante da sinagoga"}
			]
		},
		{
			"question":
			{
				"en": "Whose ear did Jesus heal in Gethsemane?",
				"pt": "De quem foi a orelha que Jesus curou no Getsêmani?"
			},
			"answer": {"en": "Malchus", "pt": "Malco"},
			"tier": 2,
			"decoys":
			[
				{"en": "Caiaphas", "pt": "Caifás"},
				{"en": "Annas", "pt": "Anás"},
				{"en": "Barabbas", "pt": "Barrabás"}
			]
		},
		{
			"question":
			{
				"en": "What happened to the man by the pool of Bethesda when Jesus spoke?",
				"pt": "O que aconteceu com o homem junto ao tanque de Betesda quando Jesus falou?"
			},
			"answer": {"en": "A paralyzed man was healed", "pt": "Um homem paralítico foi curado"},
			"tier": 3,
			"decoys":
			[
				{"en": "The waters boiled", "pt": "As águas ferveram"},
				{"en": "Angels appeared visibly", "pt": "Anjos apareceram visivelmente"},
				{"en": "It turned into wine", "pt": "Se transformou em vinho"}
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
			"tier": 1,
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
			"tier": 1,
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
			"tier": 1,
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
			"tier": 2,
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
			"tier": 2,
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
			"tier": 2,
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
			"tier": 2,
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
			"tier": 2,
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
			"tier": 2,
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
			"tier": 2,
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
			"tier": 2,
			"decoys":
			[
				{"en": "2 Thessalonians", "pt": "2 Tessalonicenses"},
				{"en": "2 Peter", "pt": "2 Pedro"},
				{"en": "Colossians", "pt": "Colossenses"}
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
			"tier": 2,
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
			"tier": 2,
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
			"tier": 2,
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
			"tier": 2,
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
			"tier": 1,
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
			"tier": 1,
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
			"tier": 1,
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
			"tier": 1,
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
			"tier": 1,
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
			"tier": 1,
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
			"tier": 1,
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
			"tier": 1,
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
		}
	]
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
		if not qa.has("decoys") or (qa["decoys"] as Array).is_empty():
			var others: Array[String] = []
			for j in range(base_list.size()):
				if j == i:
					continue
				var other_ans := str((base_list[j] as Dictionary).get("answer", ""))
				if other_ans != "":
					others.append(other_ans)
			others.shuffle()
			var decoys: Array[String] = []
			for d in others:
				if decoys.size() >= 3:
					break
				decoys.append(d)
			qa["decoys"] = decoys
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
