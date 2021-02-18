
class Cli


    def prompt
        TTY::Prompt.new
    end

    def welcome
        system "clear"
        puts "Welcome to:"
        title = Artii::Base.new(:font => "slant")
        puts title.asciify("Potions and Lotions")
        welcome_question
    end

    def welcome_question
        login = prompt.yes?("Are you a returning sorcerer?:")
        if login
            puts "Enter your name:"
            user_input = gets.chomp
            @user = Sorcerer.all.filter do |sorcerer|
                sorcerer.name == user_input
            end
        menu
        else
            puts "What is your name?:"
            name = gets.chomp
            puts "What is you skill?:"
            skill = gets.chomp
            @user = Sorcerer.create(name: name, skill: skill)
            puts "Welcome #{name}"
            menu
        end
    end

    def reset
        system("clear")
    end

    def menu
        options = prompt.select("What would you like to do?:", ["Buy new item", "See your items"])
        if options == "Buy new item"
            buy_menu
        else
            view_item
        end
    end

    def view_item
        check_item = @user[0].orders
        # binding.pry
        if check_item[0]
            use_or_view = prompt.select("Would you like to view or use your items?:", ["View", "Use"])
            if use_or_view == "View"
                item_array = check_item.all.map {|purchase| purchase.item_id}
                item_array.each {|id| puts Item.find(id).name}
                menu
            else
                item_array = check_item.all.map {|purchase| purchase.item_id}
                select_item = item_array.map {|id| Item.find(id).name}
                use_item = prompt.select("Which item would you like to use?:", select_item)                
            end
        else
            puts "You have no items yet"
            buy_menu
        end
    end

    def find_all_item(name)
        item_object = Item.all.filter do |item|
            item.name == name
        end
        item_object
        # $items = items
        # binding.pry
    end


    def buy_menu
        puts "Welcome to my shop! Won't you check my wares?........"
        sleep(2)
        puts "And be careful what you touch."
        all_items = Item.all.map {|item| item.name}
        # binding.pry
        my_item = prompt.select("Choose item:", all_items)
        @selected_item = find_all_item(my_item)
        # binding.pry
        
        sleep(2)
        reset
        let_me_see = puts "Let me see..."
        loop do
            attribute = prompt.select("Oh that's a nice item... What would you like to know about it?", ["Ability", "Rarity", "Cast Cost", "Price"])
            case attribute
            when "Ability"
                # binding.pry
                puts @selected_item[0].ability
                know_more = prompt.yes?("Would you like to know anything else about the item?:")
                if know_more
                    attribute
                else
                    buy_or_no = prompt.yes?("Time to buy or get out.")
                    if buy_or_no
                        buy_item = Order.create(sorcerer: @user[0], item:@selected_item[0])
                        break
                    else
                        break
                    end   
                end
            when "Rarity"
                puts selected_item[0].rarity
                know_more = prompt.yes?("Would you like to know anything else about the item?:")
                if know_more
                    attribute
                else
                    puts "Time to buy or get out."
                end
            when "Cast Cost"
                puts selected_item[0].cast_cost
                know_more = prompt.yes?("Would you like to know anything else about the item?:")
                if know_more
                    attribute
                else
                    puts "Time to buy or get out."
                end
            when "Price"
                puts selected_item[0].price
                know_more = prompt.yes?("Would you like to know anything else about the item?:")
                if know_more
                    attribute
                else
                    puts "Time to buy or get out."
                end
            end
        end 
        menu
    end
end

