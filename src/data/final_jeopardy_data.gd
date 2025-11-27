extends RefCounted
class_name FinalJeopardyData

# 50 harder Final Jeopardy prompts kept separate from regular tiered questions.
const FINAL_QUESTIONS := [
	{
		"category": {"en": "Prophetic Names", "pt": "Prophetic Names"},
		"question":
		{
			"en": "Which prophet named his son Maher-shalal-hash-baz as a sign to Judah?",
			"pt": "Which prophet named his son Maher-shalal-hash-baz as a sign to Judah?"
		},
		"answer": {"en": "Isaiah", "pt": "Isaiah"},
		"decoys":
		[
			{"en": "Hosea", "pt": "Hosea"},
			{"en": "Jeremiah", "pt": "Jeremiah"},
			{"en": "Ezekiel", "pt": "Ezekiel"}
		]
	},
	{
		"category": {"en": "Hidden Scroll", "pt": "Hidden Scroll"},
		"question":
		{
			"en": "Who discovered the Book of the Law during Josiah's temple repairs?",
			"pt": "Who discovered the Book of the Law during Josiah's temple repairs?"
		},
		"answer": {"en": "Hilkiah", "pt": "Hilkiah"},
		"decoys":
		[
			{"en": "Shaphan", "pt": "Shaphan"},
			{"en": "Zephaniah", "pt": "Zephaniah"},
			{"en": "Pashhur", "pt": "Pashhur"}
		]
	},
	{
		"category": {"en": "Imperial Edicts", "pt": "Imperial Edicts"},
		"question":
		{
			"en": "Which Persian king first issued the decree to rebuild the Jerusalem temple?",
			"pt": "Which Persian king first issued the decree to rebuild the Jerusalem temple?"
		},
		"answer": {"en": "Cyrus", "pt": "Cyrus"},
		"decoys":
		[
			{"en": "Darius I", "pt": "Darius I"},
			{"en": "Artaxerxes", "pt": "Artaxerxes"},
			{"en": "Xerxes", "pt": "Xerxes"}
		]
	},
	{
		"category": {"en": "Ark Witness", "pt": "Ark Witness"},
		"question":
		{
			"en":
			"What was placed beside the ark of the covenant as a witness against Israel in Deuteronomy 31?",
			"pt":
			"What was placed beside the ark of the covenant as a witness against Israel in Deuteronomy 31?"
		},
		"answer": {"en": "The book of the law", "pt": "The book of the law"},
		"decoys":
		[
			{"en": "Aaron's staff", "pt": "Aaron's staff"},
			{"en": "A jar of manna", "pt": "A jar of manna"},
			{"en": "Tribal standards", "pt": "Tribal standards"}
		]
	},
	{
		"category": {"en": "Festival Declarations", "pt": "Festival Declarations"},
		"question":
		{
			"en":
			'At which feast did Jesus cry, "If anyone thirsts, let him come to me and drink"?',
			"pt": 'At which feast did Jesus cry, "If anyone thirsts, let him come to me and drink"?'
		},
		"answer": {"en": "Feast of Tabernacles", "pt": "Feast of Tabernacles"},
		"decoys":
		[
			{"en": "Passover", "pt": "Passover"},
			{"en": "Feast of Dedication", "pt": "Feast of Dedication"},
			{"en": "Pentecost", "pt": "Pentecost"}
		]
	},
	{
		"category": {"en": "Small Town Miracles", "pt": "Small Town Miracles"},
		"question":
		{
			"en": "In which town did Jesus raise a widow's only son during a funeral procession?",
			"pt": "In which town did Jesus raise a widow's only son during a funeral procession?"
		},
		"answer": {"en": "Nain", "pt": "Nain"},
		"decoys":
		[
			{"en": "Bethany", "pt": "Bethany"},
			{"en": "Cana", "pt": "Cana"},
			{"en": "Capernaum", "pt": "Capernaum"}
		]
	},
	{
		"category": {"en": "Symbolic Acts", "pt": "Symbolic Acts"},
		"question":
		{
			"en": "Which prophet shattered a clay jar in the Valley of Hinnom to warn Judah?",
			"pt": "Which prophet shattered a clay jar in the Valley of Hinnom to warn Judah?"
		},
		"answer": {"en": "Jeremiah", "pt": "Jeremiah"},
		"decoys":
		[
			{"en": "Ezekiel", "pt": "Ezekiel"},
			{"en": "Micah", "pt": "Micah"},
			{"en": "Zephaniah", "pt": "Zephaniah"}
		]
	},
	{
		"category": {"en": "Temple Boundaries", "pt": "Temple Boundaries"},
		"question":
		{
			"en":
			"Which king was struck with leprosy for unlawfully burning incense in the temple?",
			"pt": "Which king was struck with leprosy for unlawfully burning incense in the temple?"
		},
		"answer": {"en": "Uzziah", "pt": "Uzziah"},
		"decoys":
		[
			{"en": "Ahaziah", "pt": "Ahaziah"},
			{"en": "Manasseh", "pt": "Manasseh"},
			{"en": "Jehoiakim", "pt": "Jehoiakim"}
		]
	},
	{
		"category": {"en": "Unique Psalms", "pt": "Unique Psalms"},
		"question":
		{
			"en": 'Which psalm is introduced as "A prayer of Moses, the man of God"?',
			"pt": 'Which psalm is introduced as "A prayer of Moses, the man of God"?'
		},
		"answer": {"en": "Psalm 90", "pt": "Psalm 90"},
		"decoys":
		[
			{"en": "Psalm 72", "pt": "Psalm 72"},
			{"en": "Psalm 110", "pt": "Psalm 110"},
			{"en": "Psalm 136", "pt": "Psalm 136"}
		]
	},
	{
		"category": {"en": "Night Inspections", "pt": "Night Inspections"},
		"question":
		{
			"en": "Who secretly surveyed Jerusalem's ruined walls by night before rebuilding them?",
			"pt": "Who secretly surveyed Jerusalem's ruined walls by night before rebuilding them?"
		},
		"answer": {"en": "Nehemiah", "pt": "Nehemiah"},
		"decoys":
		[
			{"en": "Ezra", "pt": "Ezra"},
			{"en": "Zerubbabel", "pt": "Zerubbabel"},
			{"en": "Haggai", "pt": "Haggai"}
		]
	},
	{
		"category": {"en": "Nazirite Vows", "pt": "Nazirite Vows"},
		"question":
		{
			"en":
			"Who vowed that her son would never have a razor touch his head, leading to Samuel's dedication?",
			"pt":
			"Who vowed that her son would never have a razor touch his head, leading to Samuel's dedication?"
		},
		"answer": {"en": "Hannah", "pt": "Hannah"},
		"decoys":
		[
			{"en": "Elisabeth", "pt": "Elisabeth"},
			{"en": "Manoah's wife", "pt": "Manoah's wife"},
			{"en": "Rebekah", "pt": "Rebekah"}
		]
	},
	{
		"category": {"en": "Costly Keepsakes", "pt": "Costly Keepsakes"},
		"question":
		{
			"en": "Which judge made a gold ephod in Ophrah that became a snare to Israel?",
			"pt": "Which judge made a gold ephod in Ophrah that became a snare to Israel?"
		},
		"answer": {"en": "Gideon", "pt": "Gideon"},
		"decoys":
		[
			{"en": "Jephthah", "pt": "Jephthah"},
			{"en": "Tola", "pt": "Tola"},
			{"en": "Abimelech", "pt": "Abimelech"}
		]
	},
	{
		"category": {"en": "Plumb Lines", "pt": "Plumb Lines"},
		"question":
		{
			"en": "Which prophet saw the Lord holding a plumb line over Israel?",
			"pt": "Which prophet saw the Lord holding a plumb line over Israel?"
		},
		"answer": {"en": "Amos", "pt": "Amos"},
		"decoys":
		[
			{"en": "Zechariah", "pt": "Zechariah"},
			{"en": "Joel", "pt": "Joel"},
			{"en": "Malachi", "pt": "Malachi"}
		]
	},
	{
		"category": {"en": "Burned Scrolls", "pt": "Burned Scrolls"},
		"question":
		{
			"en": "Which king cut up Jeremiah's scroll and burned it piece by piece?",
			"pt": "Which king cut up Jeremiah's scroll and burned it piece by piece?"
		},
		"answer": {"en": "Jehoiakim", "pt": "Jehoiakim"},
		"decoys":
		[
			{"en": "Jehoiachin", "pt": "Jehoiachin"},
			{"en": "Zedekiah", "pt": "Zedekiah"},
			{"en": "Jehoshaphat", "pt": "Jehoshaphat"}
		]
	},
	{
		"category": {"en": "Chosen Twelfth", "pt": "Chosen Twelfth"},
		"question":
		{
			"en": "Who was selected to replace Judas Iscariot among the apostles in Acts 1?",
			"pt": "Who was selected to replace Judas Iscariot among the apostles in Acts 1?"
		},
		"answer": {"en": "Matthias", "pt": "Matthias"},
		"decoys":
		[
			{"en": "Joseph called Barsabbas", "pt": "Joseph called Barsabbas"},
			{"en": "Philip", "pt": "Philip"},
			{"en": "Thaddaeus", "pt": "Thaddaeus"}
		]
	},
	{
		"category": {"en": "Prophetic Burdens", "pt": "Prophetic Burdens"},
		"question":
		{
			"en": "How many days did Ezekiel lie on his right side to bear Judah's sin?",
			"pt": "How many days did Ezekiel lie on his right side to bear Judah's sin?"
		},
		"answer": {"en": "40", "pt": "40"},
		"decoys": [{"en": "70", "pt": "70"}, {"en": "390", "pt": "390"}, {"en": "430", "pt": "430"}]
	},
	{
		"category": {"en": "Silent Mourning", "pt": "Silent Mourning"},
		"question":
		{
			"en": "Whose wife was taken by God as a sign, with a command not to mourn openly?",
			"pt": "Whose wife was taken by God as a sign, with a command not to mourn openly?"
		},
		"answer": {"en": "Ezekiel", "pt": "Ezekiel"},
		"decoys":
		[
			{"en": "Hosea", "pt": "Hosea"},
			{"en": "Isaiah", "pt": "Isaiah"},
			{"en": "Zechariah", "pt": "Zechariah"}
		]
	},
	{
		"category": {"en": "Quoted Prophets", "pt": "Quoted Prophets"},
		"question":
		{
			"en":
			"Which minor prophet is quoted by name in Acts 2 about God's Spirit being poured out?",
			"pt":
			"Which minor prophet is quoted by name in Acts 2 about God's Spirit being poured out?"
		},
		"answer": {"en": "Joel", "pt": "Joel"},
		"decoys":
		[
			{"en": "Haggai", "pt": "Haggai"},
			{"en": "Obadiah", "pt": "Obadiah"},
			{"en": "Nahum", "pt": "Nahum"}
		]
	},
	{
		"category": {"en": "Courier Teams", "pt": "Courier Teams"},
		"question":
		{
			"en": "Who carried the letter to the Colossians along with Tychicus?",
			"pt": "Who carried the letter to the Colossians along with Tychicus?"
		},
		"answer": {"en": "Onesimus", "pt": "Onesimus"},
		"decoys":
		[
			{"en": "Epaphras", "pt": "Epaphras"},
			{"en": "Aristarchus", "pt": "Aristarchus"},
			{"en": "Demas", "pt": "Demas"}
		]
	},
	{
		"category": {"en": "Christ Hymns", "pt": "Christ Hymns"},
		"question":
		{
			"en":
			'Which New Testament letter contains the hymn describing Christ "emptying himself"?',
			"pt":
			'Which New Testament letter contains the hymn describing Christ "emptying himself"?'
		},
		"answer": {"en": "Philippians", "pt": "Philippians"},
		"decoys":
		[
			{"en": "Colossians", "pt": "Colossians"},
			{"en": "Ephesians", "pt": "Ephesians"},
			{"en": "Hebrews", "pt": "Hebrews"}
		]
	},
	{
		"category": {"en": "Sealed Dens", "pt": "Sealed Dens"},
		"question":
		{
			"en": "Who sealed the lions' den with his signet after Daniel was thrown in?",
			"pt": "Who sealed the lions' den with his signet after Daniel was thrown in?"
		},
		"answer": {"en": "Darius", "pt": "Darius"},
		"decoys":
		[
			{"en": "Cyrus", "pt": "Cyrus"},
			{"en": "Nebuchadnezzar", "pt": "Nebuchadnezzar"},
			{"en": "Belshazzar", "pt": "Belshazzar"}
		]
	},
	{
		"category": {"en": "Unlikely Hosts", "pt": "Unlikely Hosts"},
		"question":
		{
			"en": "With whom did Peter stay in Joppa when he received the vision of the sheet?",
			"pt": "With whom did Peter stay in Joppa when he received the vision of the sheet?"
		},
		"answer": {"en": "Simon the tanner", "pt": "Simon the tanner"},
		"decoys":
		[
			{"en": "Cornelius", "pt": "Cornelius"},
			{"en": "Philip the evangelist", "pt": "Philip the evangelist"},
			{"en": "Aquila", "pt": "Aquila"}
		]
	},
	{
		"category": {"en": "Unexpected Revival", "pt": "Unexpected Revival"},
		"question":
		{
			"en": "Whose bones revived a dead man when they were touched?",
			"pt": "Whose bones revived a dead man when they were touched?"
		},
		"answer": {"en": "Elisha's bones", "pt": "Elisha's bones"},
		"decoys":
		[
			{"en": "Elijah's bones", "pt": "Elijah's bones"},
			{"en": "Samuel's bones", "pt": "Samuel's bones"},
			{"en": "Moses' bones", "pt": "Moses' bones"}
		]
	},
	{
		"category": {"en": "Prison Earthquake", "pt": "Prison Earthquake"},
		"question":
		{
			"en": "In what city did an earthquake open the prison doors for Paul and Silas?",
			"pt": "In what city did an earthquake open the prison doors for Paul and Silas?"
		},
		"answer": {"en": "Philippi", "pt": "Philippi"},
		"decoys":
		[
			{"en": "Corinth", "pt": "Corinth"},
			{"en": "Ephesus", "pt": "Ephesus"},
			{"en": "Thessalonica", "pt": "Thessalonica"}
		]
	},
	{
		"category": {"en": "Rechabite Resolve", "pt": "Rechabite Resolve"},
		"question":
		{
			"en":
			"Which prophet commended the Rechabites for refusing wine in obedience to their ancestor?",
			"pt":
			"Which prophet commended the Rechabites for refusing wine in obedience to their ancestor?"
		},
		"answer": {"en": "Jeremiah", "pt": "Jeremiah"},
		"decoys":
		[
			{"en": "Isaiah", "pt": "Isaiah"},
			{"en": "Amos", "pt": "Amos"},
			{"en": "Zephaniah", "pt": "Zephaniah"}
		]
	},
	{
		"category": {"en": "Wisdom Voices", "pt": "Wisdom Voices"},
		"question":
		{
			"en": "Which sage identified as the son of Jakeh contributed sayings in Proverbs?",
			"pt": "Which sage identified as the son of Jakeh contributed sayings in Proverbs?"
		},
		"answer": {"en": "Agur", "pt": "Agur"},
		"decoys":
		[
			{"en": "Lemuel", "pt": "Lemuel"},
			{"en": "Ethan", "pt": "Ethan"},
			{"en": "Heman", "pt": "Heman"}
		]
	},
	{
		"category": {"en": "Royal Refusals", "pt": "Royal Refusals"},
		"question":
		{
			"en": "Which queen refused to appear for King Xerxes before Esther was chosen?",
			"pt": "Which queen refused to appear for King Xerxes before Esther was chosen?"
		},
		"answer": {"en": "Vashti", "pt": "Vashti"},
		"decoys":
		[
			{"en": "Athaliah", "pt": "Athaliah"},
			{"en": "Jezebel", "pt": "Jezebel"},
			{"en": "Maacah", "pt": "Maacah"}
		]
	},
	{
		"category": {"en": "Witness Altar", "pt": "Witness Altar"},
		"question":
		{
			"en":
			"What name did the eastern tribes give the large altar they built by the Jordan in Joshua 22?",
			"pt":
			"What name did the eastern tribes give the large altar they built by the Jordan in Joshua 22?"
		},
		"answer": {"en": "Witness", "pt": "Witness"},
		"decoys":
		[
			{"en": "Ebenezer", "pt": "Ebenezer"},
			{"en": "Mizpah", "pt": "Mizpah"},
			{"en": "Gilgal", "pt": "Gilgal"}
		]
	},
	{
		"category": {"en": "Last Judge", "pt": "Last Judge"},
		"question":
		{
			"en": "Who served as Israel's final judge before the monarchy?",
			"pt": "Who served as Israel's final judge before the monarchy?"
		},
		"answer": {"en": "Samuel", "pt": "Samuel"},
		"decoys":
		[
			{"en": "Eli", "pt": "Eli"},
			{"en": "Jephthah", "pt": "Jephthah"},
			{"en": "Othniel", "pt": "Othniel"}
		]
	},
	{
		"category": {"en": "River Remedy", "pt": "River Remedy"},
		"question":
		{
			"en": "In which river did Naaman wash seven times at Elisha's command?",
			"pt": "In which river did Naaman wash seven times at Elisha's command?"
		},
		"answer": {"en": "Jordan", "pt": "Jordan"},
		"decoys":
		[
			{"en": "Abanah", "pt": "Abanah"},
			{"en": "Pharpar", "pt": "Pharpar"},
			{"en": "Orontes", "pt": "Orontes"}
		]
	},
	{
		"category": {"en": "Lampstand Vision", "pt": "Lampstand Vision"},
		"question":
		{
			"en": "Who saw two olive trees feeding a golden lampstand in a vision?",
			"pt": "Who saw two olive trees feeding a golden lampstand in a vision?"
		},
		"answer": {"en": "Zechariah", "pt": "Zechariah"},
		"decoys":
		[
			{"en": "Ezekiel", "pt": "Ezekiel"},
			{"en": "Daniel", "pt": "Daniel"},
			{"en": "Malachi", "pt": "Malachi"}
		]
	},
	{
		"category": {"en": "Counter Counsel", "pt": "Counter Counsel"},
		"question":
		{
			"en": "Whose advice defeated Ahithophel's counsel during Absalom's rebellion?",
			"pt": "Whose advice defeated Ahithophel's counsel during Absalom's rebellion?"
		},
		"answer": {"en": "Hushai the Arkite", "pt": "Hushai the Arkite"},
		"decoys":
		[
			{"en": "Ittai the Gittite", "pt": "Ittai the Gittite"},
			{"en": "Zadok the priest", "pt": "Zadok the priest"},
			{"en": "Joab", "pt": "Joab"}
		]
	},
	{
		"category": {"en": "Sweetened Springs", "pt": "Sweetened Springs"},
		"question":
		{
			"en":
			"What was the name of the place where bitter waters were made sweet after Moses threw in wood?",
			"pt":
			"What was the name of the place where bitter waters were made sweet after Moses threw in wood?"
		},
		"answer": {"en": "Marah", "pt": "Marah"},
		"decoys":
		[
			{"en": "Meribah", "pt": "Meribah"},
			{"en": "Elim", "pt": "Elim"},
			{"en": "Rephidim", "pt": "Rephidim"}
		]
	},
	{
		"category": {"en": "Tentmakers", "pt": "Tentmakers"},
		"question":
		{
			"en": "Which fellow tentmaker partnered with Paul in Corinth?",
			"pt": "Which fellow tentmaker partnered with Paul in Corinth?"
		},
		"answer": {"en": "Aquila", "pt": "Aquila"},
		"decoys":
		[
			{"en": "Apollos", "pt": "Apollos"},
			{"en": "Trophimus", "pt": "Trophimus"},
			{"en": "Luke", "pt": "Luke"}
		]
	},
	{
		"category": {"en": "Solo Deliverer", "pt": "Solo Deliverer"},
		"question":
		{
			"en": "Which judge struck down six hundred Philistines with an oxgoad?",
			"pt": "Which judge struck down six hundred Philistines with an oxgoad?"
		},
		"answer": {"en": "Shamgar", "pt": "Shamgar"},
		"decoys":
		[
			{"en": "Ehud", "pt": "Ehud"},
			{"en": "Barak", "pt": "Barak"},
			{"en": "Ibzan", "pt": "Ibzan"}
		]
	},
	{
		"category": {"en": "Faithful Scribe", "pt": "Faithful Scribe"},
		"question":
		{
			"en": "Who served as Jeremiah's scribe, writing and rewriting his prophecies?",
			"pt": "Who served as Jeremiah's scribe, writing and rewriting his prophecies?"
		},
		"answer": {"en": "Baruch son of Neriah", "pt": "Baruch son of Neriah"},
		"decoys":
		[
			{"en": "Shaphan", "pt": "Shaphan"},
			{"en": "Ezra", "pt": "Ezra"},
			{"en": "Gemariah", "pt": "Gemariah"}
		]
	},
	{
		"category": {"en": "Post-Exile Leaders", "pt": "Post-Exile Leaders"},
		"question":
		{
			"en": "Whom did Haggai call God's signet ring after the exile?",
			"pt": "Whom did Haggai call God's signet ring after the exile?"
		},
		"answer": {"en": "Zerubbabel", "pt": "Zerubbabel"},
		"decoys":
		[
			{"en": "Joshua son of Jehozadak", "pt": "Joshua son of Jehozadak"},
			{"en": "Ezra", "pt": "Ezra"},
			{"en": "Nehemiah", "pt": "Nehemiah"}
		]
	},
	{
		"category": {"en": "Song of Deborah", "pt": "Song of Deborah"},
		"question":
		{
			"en": "Which river is said to have swept away Sisera's army in the Song of Deborah?",
			"pt": "Which river is said to have swept away Sisera's army in the Song of Deborah?"
		},
		"answer": {"en": "Kishon", "pt": "Kishon"},
		"decoys":
		[
			{"en": "Jordan", "pt": "Jordan"},
			{"en": "Jabbok", "pt": "Jabbok"},
			{"en": "Arnon", "pt": "Arnon"}
		]
	},
	{
		"category": {"en": "Vow Kept", "pt": "Vow Kept"},
		"question":
		{
			"en": "In which port city did Paul cut his hair because of a vow?",
			"pt": "In which port city did Paul cut his hair because of a vow?"
		},
		"answer": {"en": "Cenchreae", "pt": "Cenchreae"},
		"decoys":
		[
			{"en": "Corinth", "pt": "Corinth"},
			{"en": "Caesarea", "pt": "Caesarea"},
			{"en": "Troas", "pt": "Troas"}
		]
	},
	{
		"category": {"en": "Hidden Prophets", "pt": "Hidden Prophets"},
		"question":
		{
			"en": "Who hid a hundred prophets in caves to protect them from Jezebel?",
			"pt": "Who hid a hundred prophets in caves to protect them from Jezebel?"
		},
		"answer": {"en": "Obadiah", "pt": "Obadiah"},
		"decoys":
		[
			{"en": "Jehu", "pt": "Jehu"},
			{"en": "Jehoiada", "pt": "Jehoiada"},
			{"en": "Elijah", "pt": "Elijah"}
		]
	},
	{
		"category": {"en": "Field of Blood", "pt": "Field of Blood"},
		"question":
		{
			"en": "What Aramaic name was given to the field purchased with Judas' betrayal money?",
			"pt": "What Aramaic name was given to the field purchased with Judas' betrayal money?"
		},
		"answer": {"en": "Akeldama", "pt": "Akeldama"},
		"decoys":
		[
			{"en": "Kidron", "pt": "Kidron"},
			{"en": "Potter's Field", "pt": "Potter's Field"},
			{"en": "Gehenna", "pt": "Gehenna"}
		]
	},
	{
		"category": {"en": "First Return", "pt": "First Return"},
		"question":
		{
			"en": "Who, called a prince of Judah, brought back temple vessels under Cyrus' decree?",
			"pt": "Who, called a prince of Judah, brought back temple vessels under Cyrus' decree?"
		},
		"answer": {"en": "Sheshbazzar", "pt": "Sheshbazzar"},
		"decoys":
		[
			{"en": "Zerubbabel", "pt": "Zerubbabel"},
			{"en": "Nehemiah", "pt": "Nehemiah"},
			{"en": "Ezra", "pt": "Ezra"}
		]
	},
	{
		"category": {"en": "Late Night Meeting", "pt": "Late Night Meeting"},
		"question":
		{
			"en": "Who fell from a third-story window in Troas and was raised by Paul?",
			"pt": "Who fell from a third-story window in Troas and was raised by Paul?"
		},
		"answer": {"en": "Eutychus", "pt": "Eutychus"},
		"decoys":
		[
			{"en": "Tychicus", "pt": "Tychicus"},
			{"en": "Epaphras", "pt": "Epaphras"},
			{"en": "Demetrius", "pt": "Demetrius"}
		]
	},
	{
		"category": {"en": "Open Heart", "pt": "Open Heart"},
		"question":
		{
			"en": "Which seller of purple became Paul's first recorded convert in Philippi?",
			"pt": "Which seller of purple became Paul's first recorded convert in Philippi?"
		},
		"answer": {"en": "Lydia", "pt": "Lydia"},
		"decoys":
		[
			{"en": "Priscilla", "pt": "Priscilla"},
			{"en": "Damaris", "pt": "Damaris"},
			{"en": "Sapphira", "pt": "Sapphira"}
		]
	},
	{
		"category": {"en": "Shortest Oracle", "pt": "Shortest Oracle"},
		"question":
		{
			"en": "Which prophet wrote the one-chapter book rebuking Edom?",
			"pt": "Which prophet wrote the one-chapter book rebuking Edom?"
		},
		"answer": {"en": "Obadiah", "pt": "Obadiah"},
		"decoys":
		[
			{"en": "Nahum", "pt": "Nahum"},
			{"en": "Habakkuk", "pt": "Habakkuk"},
			{"en": "Micah", "pt": "Micah"}
		]
	},
	{
		"category": {"en": "New Capital", "pt": "New Capital"},
		"question":
		{
			"en": "Which king built the city of Samaria and made it Israel's capital?",
			"pt": "Which king built the city of Samaria and made it Israel's capital?"
		},
		"answer": {"en": "Omri", "pt": "Omri"},
		"decoys":
		[
			{"en": "Ahab", "pt": "Ahab"},
			{"en": "Jeroboam I", "pt": "Jeroboam I"},
			{"en": "Baasha", "pt": "Baasha"}
		]
	},
	{
		"category": {"en": "Carmel Challenge", "pt": "Carmel Challenge"},
		"question":
		{
			"en": 'Who asked Israel, "How long will you go limping between two opinions?"',
			"pt": 'Who asked Israel, "How long will you go limping between two opinions?"'
		},
		"answer": {"en": "Elijah", "pt": "Elijah"},
		"decoys":
		[
			{"en": "Elisha", "pt": "Elisha"},
			{"en": "Nathan", "pt": "Nathan"},
			{"en": "Samuel", "pt": "Samuel"}
		]
	},
	{
		"category": {"en": "Healing Jericho", "pt": "Healing Jericho"},
		"question":
		{
			"en": "What did Elisha throw into the spring at Jericho to heal the water?",
			"pt": "What did Elisha throw into the spring at Jericho to heal the water?"
		},
		"answer": {"en": "Salt", "pt": "Salt"},
		"decoys":
		[
			{"en": "Fig cakes", "pt": "Fig cakes"},
			{"en": "Flour", "pt": "Flour"},
			{"en": "Oil", "pt": "Oil"}
		]
	},
	{
		"category": {"en": "Son of Encouragement", "pt": "Son of Encouragement"},
		"question":
		{
			"en":
			"Who sold a field and laid the money at the apostles' feet, earning the name Barnabas?",
			"pt":
			"Who sold a field and laid the money at the apostles' feet, earning the name Barnabas?"
		},
		"answer": {"en": "Joseph called Barnabas", "pt": "Joseph called Barnabas"},
		"decoys":
		[
			{"en": "Ananias", "pt": "Ananias"},
			{"en": "Silas", "pt": "Silas"},
			{"en": "Stephen", "pt": "Stephen"}
		]
	},
	{
		"category": {"en": "Waiting Elder", "pt": "Waiting Elder"},
		"question":
		{
			"en":
			"Which righteous man in the temple held the infant Jesus and said he could depart in peace?",
			"pt":
			"Which righteous man in the temple held the infant Jesus and said he could depart in peace?"
		},
		"answer": {"en": "Simeon", "pt": "Simeon"},
		"decoys":
		[
			{"en": "Zechariah", "pt": "Zechariah"},
			{"en": "Caiaphas", "pt": "Caiaphas"},
			{"en": "Gamaliel", "pt": "Gamaliel"}
		]
	}
]

static var CURRENT_LANGUAGE := "en"


static func set_language(lang: String) -> void:
	CURRENT_LANGUAGE = "pt" if lang == "pt" else "en"


static func _localized_text(value, lang: String) -> String:
	if value is Dictionary:
		var dict := value as Dictionary
		return str(dict.get(lang, dict.get("en", "")))
	return str(value)


static func _localize_question(data: Dictionary) -> Dictionary:
	var decoys: Array[String] = []
	if data.has("decoys"):
		for d in data["decoys"] as Array:
			decoys.append(_localized_text(d, CURRENT_LANGUAGE))
	return {
		"category": _localized_text(data.get("category", "Final Jeopardy"), CURRENT_LANGUAGE),
		"question": _localized_text(data.get("question", ""), CURRENT_LANGUAGE),
		"answer": _localized_text(data.get("answer", ""), CURRENT_LANGUAGE),
		"decoys": decoys
	}


static func get_random_question() -> Dictionary:
	if FINAL_QUESTIONS.is_empty():
		return {}
	var idx := randi() % FINAL_QUESTIONS.size()
	return _localize_question(FINAL_QUESTIONS[idx])


static func get_all_questions() -> Array:
	var pool: Array = []
	for q in FINAL_QUESTIONS:
		pool.append(_localize_question(q))
	return pool
