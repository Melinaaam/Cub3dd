NAME = cub3d
BONUS = cub3d_bonus

CC = cc
CFLAGS = -Wall -Wextra -Werror -g3

SRCS_DIR = srcs
OBJ_DIR = objs
SRCS_DIR_BONUS = srcs_bonus
OBJ_DIR_BONUS = objs_bonus

INCDIR = includes minilibx
LIBFT_DIR = libft

SRCS_NAMES =	main.c \
				check_map_file.c \
				map_file_parse.c \
				get_texture.c \
				recup_color.c \
				check_color.c \
				map_parse.c \
				map_access.c \
				create_rgb.c \
				utils.c \
				free.c \
				render_game.c \
				moves.c \
				put_img.c

OBJS_NAMES = $(SRCS_NAMES:.c=.o)
SRCS = $(addprefix $(SRCS_DIR)/,$(SRCS_NAMES))
OBJS = $(addprefix $(OBJ_DIR)/,$(OBJS_NAMES))

SRCS_N_BONUS =	main_bonus.c \
				barrier_bonus.c \
				check_map_file_bonus.c \
				map_file_parse_bonus.c \
				get_texture_bonus.c \
				recup_color_bonus.c \
				check_color_bonus.c \
				map_parse_bonus.c \
				map_parse_door_bonus.c \
				map_access_bonus.c \
				create_rgb_bonus.c \
				init_game_bonus.c \
				utils_bonus.c \
				free_bonus.c \
				render_game_bonus.c \
				moves_bonus.c \
				get_radius_bonus.c \
				render_mini_map_bonus.c \
				update_handlebars_bonus.c \
				mouse_bonus.c \
				ray_to_door_bonus.c \
				render_barrier_bonus.c \
				render_handlebars_bonus.c \
				put_img_bonus.c

OBJS_N_BONUS = $(SRCS_N_BONUS:.c=.o)
SRCS_BONUS = $(addprefix $(SRCS_DIR_BONUS)/,$(SRCS_N_BONUS))
OBJS_BONUS = $(addprefix $(OBJ_DIR_BONUS)/,$(OBJS_N_BONUS))

INCLUDES = $(addprefix -I, $(INCDIR)) -I$(LIBFT_DIR)
LIBS = -L./minilibx-linux -lmlx -lXext -lX11 -lm -lz -L$(LIBFT_DIR) -lft

CYAN = \033[38;5;45m
PINK = \033[38;5;213m
GREEN = \033[32m
YELLOW = \033[38;5;220m
RESET = \033[0m
BOLD = \033[1m
BIKE_MAIN  = 🚴
BIKE_BONUS = 🚵


all: $(NAME)
bonus: $(BONUS)

$(NAME): $(OBJ_DIR) $(OBJS) $(LIBFT_DIR)/libft.a
	@echo "$(BOLD)$(PINK)Compilons $(NAME)...$(RESET)"
	@make -C minilibx-linux --no-print-directory > /dev/null 2>&1
	@$(CC) $(CFLAGS) $(OBJS) $(LIBS) -o $(NAME)
	@echo "$(BOLD)$(GREEN)$(BIKE_MAIN) Prête à prendre la route !$(RESET)"

$(BONUS): $(OBJ_DIR_BONUS) $(OBJS_BONUS) $(LIBFT_DIR)/libft.a
	@echo "$(BOLD)$(PINK)Compilons $(BONUS)...$(RESET)"
	@make -C minilibx-linux --no-print-directory > /dev/null 2>&1
	@$(CC) $(CFLAGS) $(OBJS_BONUS) $(LIBS) -o $(BONUS)
	@echo "$(BOLD)$(YELLOW)$(BIKE_BONUS) Allez on va plus loin !$(RESET)"

$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

$(OBJ_DIR_BONUS):
	@mkdir -p $(OBJ_DIR_BONUS)

show-bike-main:
	@if [ ! -f .bike_main ]; then echo -n "" > .bike_main; fi
	@echo -n "$(BIKE_MAIN)" >> .bike_main
	@printf "$(CYAN) %s$(RESET)\r" "$$(cat .bike_main)"

show-bike-bonus:
	@if [ ! -f .bike_bonus ]; then echo -n "" > .bike_bonus; fi
	@echo -n "$(BIKE_BONUS)" >> .bike_bonus
	@printf "$(CYAN) %s$(RESET)\r" "$$(cat .bike_bonus)"

$(OBJ_DIR)/%.o: $(SRCS_DIR)/%.c | $(OBJ_DIR)
	@$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@ 
	@$(MAKE) --no-print-directory show-bike-main

$(OBJ_DIR_BONUS)/%.o: $(SRCS_DIR_BONUS)/%.c | $(OBJ_DIR_BONUS)
	@$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@ > /dev/null 2>&1
	@$(MAKE) --no-print-directory show-bike-bonus

$(LIBFT_DIR)/libft.a:
	@make -C $(LIBFT_DIR) --no-print-directory > /dev/null 2>&1

clean:
	@rm -rf $(OBJ_DIR) $(OBJ_DIR_BONUS)
	@rm -f .bike_main .bike_bonus
	@make clean -C minilibx-linux --no-print-directory > /dev/null 2>&1
	@make clean -C $(LIBFT_DIR) --no-print-directory > /dev/null 2>&1
	@echo "$(BOLD)$(CYAN)$(BIKE_MAIN) On fait un demi-tour et on range tout !$(RESET)"

fclean: clean
	@rm -f $(NAME) $(BONUS)
	@make fclean -C $(LIBFT_DIR) --no-print-directory > /dev/null 2>&1
	@echo "$(BOLD)$(BLUE)$(BIKE_MAIN) Tout est nettoyé, plus aucune trace !$(RESET)"

re: fclean all

.PHONY: all bonus clean fclean re show-bike-main show-bike-bonus
