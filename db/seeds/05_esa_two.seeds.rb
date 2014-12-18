esa_one = Esa.find(1)   
esa_two = Esa.find(2)

area_one = Area.create( title: 'Add Entertainment Center', icon_image:  File.open("#{Rails.root}/app/assets/images/seeds_images/area_1.png")  )
area_two = Area.create( title: 'Add Home Office', icon_image:  File.open("#{Rails.root}/app/assets/images/seeds_images/areas_selected.png") )


items_one = Item.create([{ name: 'TV', parent_id: nil, nivel: 1 , energy_value: 360, max_sockets: 1} , { name: 'DVD player', parent_id: nil, nivel: 1 , energy_value: 240 }, { name: 'VCR', parent_id: nil, nivel: 1 , energy_value: 210 }, { name: 'Use as a clock', parent_id: 21, nivel: 2 , energy_value: 70 }, { name: 'Records shows when TV is off', parent_id: 21 , nivel: 2 , energy_value: 60 }, { name: 'External sound system for TV' , parent_id: nil, nivel: 1 , energy_value: 400 }, { name: 'Other items connected to this TV', parent_id: nil, nivel: 1 ,  energy_value: nil }, { name: 'Another DVD player', parent_id: 25, nivel: 2 , energy_value: 50 }, { name: 'Another VCR', parent_id: 25, nivel: 2 , energy_value: 50 }])
items_two = Item.create([{ name: 'TV', parent_id: nil, nivel: 1 , energy_value: 360, max_sockets: 1} , { name: 'DVD player', parent_id: nil, nivel: 1 , energy_value: 240 }, { name: 'VCR', parent_id: nil, nivel: 1 , energy_value: 210 }, { name: 'Use as a clock', parent_id: 30, nivel: 2 , energy_value: 70 }, { name: 'Records shows when TV is off', parent_id: 30 , nivel: 2 , energy_value: 60 }, { name: 'External sound system for TV' , parent_id: nil, nivel: 1 , energy_value: 400 }, { name: 'Other items connected to this TV', parent_id: nil, nivel: 1 , energy_value: nil }, { name: 'Another DVD player', parent_id: 34, nivel: 2 , energy_value: 50 }, { name: 'Another VCR', parent_id: 34, nivel: 2 , energy_value: 50 }])

recommendations_one = Recommendation.create(total_energy_value: 1352,title: "Use a Smart Power 1.We\'ll show you how" )
recommendations_two = Recommendation.create(total_energy_value: 600 , title:"Use a Chrome Cast")
recommendations_three = Recommendation.create(total_energy_value: 1352, title:"Use a Smart Power 1.We\'ll show you how" )
recommendations_four = Recommendation.create(total_energy_value: 600,title: "Use a Chrome Cast" )

recommendation_item_one = RecommendationItem.create([{ comment: 'Use a Smart Power 1.We\'ll show you how ', cost: 52, amazon_code: "B000L9A7ZS" },{ comment: 'Use a Smart TV ', cost: 900, energy_value: 200, amazon_code: "B00HZI0Y0Q" },{ comment: 'Use a blue ray', cost: 1800, energy_value: 400 , amazon_code: "B00ICDAAX4"}])

recommendation_item_two = RecommendationItem.create([{ comment: 'Use a Chrome Cast', cost: 52, energy_value: 500, amazon_code: "B00DR0PDNE" },{ comment: 'Use an Apple TV', cost: 900, energy_value: 600 , amazon_code: "B007IQGLO8"},{ comment: 'Use a home theader', cost: 1800, energy_value: 700, amazon_code: "B00BI22U3O" }])

recommendation_item_three = RecommendationItem.create([{ comment: 'Use a Smart Power 1.We\'ll show you how ', cost: 52, amazon_code: "B000L9A7ZS"},{ comment: 'Use a Smart TV ', cost: 900, energy_value: 200, amazon_code: "B00HZI0Y0Q" },{ comment: 'Use a blue ray', cost: 1800,  energy_value: 400, amazon_code: "B00ICDAAX4" }])

recommendation_item_four = RecommendationItem.create([{ comment: 'Use a Chrome Cast', cost: 52 , energy_value: 500, amazon_code: "B00DR0PDNE" },{ comment: 'Use an Apple TV', cost: 900, energy_value: 600, amazon_code: "B007IQGLO8" },{ comment: 'Use a home theader', cost: 1800 , energy_value: 700, amazon_code: "B00BI22U3O" }])


steps_one = Step.create([{ description: 'Gather everything on your shopping list for this area' },{ description: 'Plug TV into power strip control outlet.' },{ description: 'Plug DVD. VCR, and external sound system into power strip switched outlets.'},{ description: 'Plug power strip  into electrical power'},{ description: 'Turn on TV . DVD, VCR, and external antena should have power.'},{ description: 'Turn off TV . DVD, VCR, and external antena should not have power. '}])

steps_two = Step.create([{ description: 'Gather everything on your shopping list for this area' },{ description: 'Plug TV into power strip control outlet.' },{ description: 'Plug DVD. VCR, and external sound system into power strip switched outlets.'},{ description: 'Plug power strip  into electrical power'},{ description: 'Turn on TV . DVD, VCR, and external antena should have power.'},{ description: 'Turn off TV . DVD, VCR, and external antena should not have power. '}])

steps_three = Step.create([{ description: 'Gather everything on your shopping list for this area' },{ description: 'Plug TV into power strip control outlet.' },{ description: 'Plug DVD. VCR, and external sound system into power strip switched outlets.'},{ description: 'Plug power strip  into electrical power'},{ description: 'Turn on TV . DVD, VCR, and external antena should have power.'},{ description: 'Turn off TV . DVD, VCR, and external antena should not have power. '}])

steps_four = Step.create([{ description: 'Gather everything on your shopping list for this area' },{ description: 'Plug TV into power strip control outlet.' },{ description: 'Plug DVD. VCR, and external sound system into power strip switched outlets.'},{ description: 'Plug power strip  into electrical power'},{ description: 'Turn on TV . DVD, VCR, and external antena should have power.'},{ description: 'Turn off TV . DVD, VCR, and external antena should not have power. '}])

recommendations_one.recommendation_items = recommendation_item_one
recommendations_two.recommendation_items = recommendation_item_two
recommendations_three.recommendation_items = recommendation_item_three
recommendations_four.recommendation_items = recommendation_item_four


recommendations_one.steps = steps_one 
recommendations_two.steps = steps_two 
recommendations_three.steps = steps_three  
recommendations_four.steps = steps_four

area_one.items += items_one 
area_two.items += items_two 


area_one.recommendations << recommendations_one 
area_one.recommendations << recommendations_two 
area_two.recommendations << recommendations_three 
area_two.recommendations << recommendations_four 


esa_one.areas += [area_two]
esa_two.areas += [area_one]