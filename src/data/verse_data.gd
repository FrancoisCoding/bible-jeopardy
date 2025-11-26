# res://src/data/verse_data.gd
class_name VerseData
extends RefCounted

const VERSES: Array = [
	{
		"reference": "John 3:16",
		"text":
		{
			"en":
			"For God so loved the world that he gave his one and only Son, that whoever believes in him shall not perish but have eternal life.",
			"pt":
			"Porque Deus amou ao mundo de tal maneira que deu o seu Filho unico, para que todo o que nele cre nao pereca, mas tenha a vida eterna."
		}
	},
	{
		"reference": "Psalm 23:1",
		"text":
		{
			"en": "The Lord is my shepherd, I lack nothing.",
			"pt": "O Senhor e o meu pastor; nada me faltara."
		}
	},
	{
		"reference": "Philippians 4:13",
		"text":
		{
			"en": "I can do all this through him who gives me strength.",
			"pt": "Tudo posso naquele que me fortalece."
		}
	},
	{
		"reference": "Proverbs 3:5",
		"text":
		{
			"en": "Trust in the Lord with all your heart and lean not on your own understanding.",
			"pt":
			"Confia no Senhor de todo o teu coracao e nao te estribes no teu proprio entendimento."
		}
	},
	{
		"reference": "Romans 8:28",
		"text":
		{
			"en":
			"And we know that in all things God works for the good of those who love him, who have been called according to his purpose.",
			"pt":
			"Sabemos que todas as coisas cooperam para o bem daqueles que amam a Deus, daqueles que sao chamados segundo o seu proposito."
		}
	},
	{
		"reference": "Isaiah 40:31",
		"text":
		{
			"en":
			"But those who hope in the Lord will renew their strength. They will soar on wings like eagles; they will run and not grow weary, they will walk and not be faint.",
			"pt":
			"Os que esperam no Senhor renovam as suas forcas, sobem com asas como aguias, correm e nao se cansam, caminham e nao se fatigam."
		}
	},
	{
		"reference": "Joshua 1:9",
		"text":
		{
			"en":
			"Be strong and courageous. Do not be afraid; do not be discouraged, for the Lord your God will be with you wherever you go.",
			"pt":
			"Se forte e corajoso; nao temas, porque o Senhor teu Deus e contigo por onde quer que andares."
		}
	},
	{
		"reference": "Matthew 6:33",
		"text":
		{
			"en":
			"But seek first his kingdom and his righteousness, and all these things will be given to you as well.",
			"pt":
			"Buscai primeiro o reino de Deus e a sua justica, e todas estas coisas vos serao acrescentadas."
		}
	},
	{
		"reference": "1 Corinthians 13:4-5",
		"text":
		{
			"en":
			"Love is patient, love is kind. It does not envy, it does not boast, it is not proud. It does not dishonor others, it is not self-seeking, it is not easily angered, it keeps no record of wrongs.",
			"pt":
			"O amor e paciente, e benigno; nao arde em ciumes, nao se vangloria, nao se ensoberbece. Nao se porta inconvenientemente, nao busca os seus interesses, nao se irrita, nao suspeita mal."
		}
	},
	{
		"reference": "Psalm 118:24",
		"text":
		{
			"en": "This is the day the Lord has made; let us rejoice and be glad in it.",
			"pt": "Este e o dia que fez o Senhor; regozijemo-nos e alegremo-nos nele."
		}
	}
]


func get_for_key(key: String, lang: String = "en") -> Dictionary:
	if VERSES.is_empty():
		return {}
	var h := int(key.hash())
	var idx := (h % VERSES.size() + VERSES.size()) % VERSES.size()
	var verse := VERSES[idx] as Dictionary
	var out := {"reference": verse.get("reference", ""), "text": verse.get("text", {})}
	return out
