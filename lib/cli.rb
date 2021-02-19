
class Cli


    def prompt
        TTY::Prompt.new(symbols: {marker: '👺'})
    end

    def welcome
        system "clear"
        puts "Welcome to:"
        title = Artii::Base.new(:font => "slant")
        puts title.asciify("Potions and Lotions").green
        welcome_question
    end

    def welcome_question
        login = prompt.yes?("Are you a returning sorcerer?:")
        if login
            puts "Enter your name:"
            user_input = gets.chomp
            @user = Sorcerer.all.find do |sorcerer|
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
        reset
        options = prompt.select("What would you like to do?:", ["Buy new item", "See your items", "Exit"])
        if options == "Buy new item"
            buy_menu
        elsif options == "See your items"
            view_item
        else
            exit!
        end
    end

    def view_item
        # binding.pry
        check_item = @user.orders.reload
        # binding.pry
        if check_item[0]
            use_or_view = prompt.select("Would you like to view or use your items?:", ["View", "Use"])
            # binding.pry
            if use_or_view == "View"
                item_array = check_item.all.map {|purchase| purchase.item_id}
                item_array.each {|id| puts Item.find(id).name}
                sleep(3)
                menu
            else
                item_array = check_item.all.map {|purchase| purchase.item_id}
                select_item = item_array.map {|id| Item.find(id).name}
                use_item = prompt.select("Which item would you like to use?:", select_item)
                # Item.find_by(name: use_item).destroy
                if use_item == "Amulet of the Drunkard"
                    system('clear')
                    puts "💀You are now so inebriated you can no longer use this app💀"
                    sleep(2)
                    exit!
                elsif use_item == "Eye of Newt"
                    system('clear')
                    puts "🐸You turned into a frog so you can't use this app🐸"
                    sleep(2)
                    exit!
                elsif use_item == "Broom of Flying"
                    system('clear')
                    puts "🚀Your app flew away... tough luck!🚀"
                    sleep(2)
                    exit!
                end
            end
        else
            puts "You have no items yet"
            buy_menu
        end
    end

    # def find_all_item(name)
    #     item_object = Item.all.filter do |item|
    #         item.name == name
    #     end
    #     item_object
    #     # $items = items
    #     # binding.pry
    # end


    def buy_menu
        puts "Welcome to my shop! Won't you check my wares?........"
        sleep(2)
        puts "And be careful what you touch."
        # all_items = Item.all.map {|item| item.name}
        # binding.pry my_hash = {item.name => item}
        item_hash = Item.all.map{|item| [item.name, item]}.to_h
        # my_item = prompt.select("Choose item:", all_items)
        @selected_item = prompt.select("Choose item:", item_hash)
        # binding.pry
        
        sleep(2)
        reset
        let_me_see = puts "Let me see..."
        loop do
            attribute = prompt.select("Oh that's a nice item... What would you like to know about it?", ["Ability", "Rarity", "Cast Cost", "Price"])
            case attribute
            when "Ability"
                # binding.pry
                puts @selected_item.ability
                know_more = prompt.yes?("Would you like to know anything else about the item?:")
                if know_more
                    attribute
                else
                    buy_or_no = prompt.yes?("Time to buy or get out.")
                    if buy_or_no
                        buy_item = Order.create(sorcerer: @user, item:@selected_item)
                        break
                    else
                        break
                    end   
                end
            when "Rarity"
                puts @selected_item.rarity
                know_more = prompt.yes?("Would you like to know anything else about the item?:")
                if know_more
                    attribute
                else
                    buy_or_no = prompt.yes?("Time to buy or get out.")
                    if buy_or_no
                        buy_item = Order.create(sorcerer: @user, item:@selected_item)
                        break
                    else
                        break
                    end   
                end
            when "Cast Cost"
                puts @selected_item.cast_cost
                know_more = prompt.yes?("Would you like to know anything else about the item?:")
                if know_more
                    attribute
                else
                    buy_or_no = prompt.yes?("Time to buy or get out.")
                    if buy_or_no
                        buy_item = Order.create(sorcerer: @user, item:@selected_item)
                        break
                    else
                        break
                    end   
                end
            when "Price"
                puts @selected_item.price
                know_more = prompt.yes?("Would you like to know anything else about the item?:")
                if know_more
                    attribute
                else
                    buy_or_no = prompt.yes?("Time to buy or get out.")
                    if buy_or_no
                        buy_item = Order.create(sorcerer: @user, item:@selected_item)
                        break
                    else
                        break
                    end   
                end
            end
        end 
        menu
    end
end

