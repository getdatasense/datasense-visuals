# Sources of Voting Information for
# Hareidi and Modern Orthodox communities

library(tidyverse)
library(tidytext)

# Create data from the original visual
# Manually input the data
dt <- tibble::tibble(
  Group = c("Haredi", "Modern Orthodox"),
  `English-language Jewish newspapers, magazines` = c(0.6, 0.53),
  `Internet (unfiltered, unblocked)` = c(0.49, 0.76),
  `Social Media (WhatsApp, Facebook, Twitter, Instagram, etc.)` = c(0.35, 0.37),
  `Non-Jewish newspapers, magazines` = c(0.32, 0.74),
  `Non-Jewish radio or TV` = c(0.3, 0.47),
  `Internet (filtered, blocked)` = c(0.29, 0.07),
  `Spouse or family members` = c(0.27, 0.2),
  `Personal connections (other family, friends, people in your community)` = c(0.27, 0.26),
  `Religious leaders - your rav, rosh yeshiva/rebbeim, shul rabbi, etc.` = c(0.17, 0.05),
  `Yiddish-language Jewish newspapers, magazines` = c(0.1, 0.0001),
  `Billboards, posters, Pashkevilin` = c(0.0001, 0.0001),
  `Other - Please describe` = c(0.05, 0.04)
)

# Transform for the visual with adjusted ordering
dt_viz <- dt |>
  tidyr::pivot_longer(
    cols = `English-language Jewish newspapers, magazines`:`Other - Please describe`,
    names_to = "Source",
    values_to = "Percent"
  ) |>
  # Highlight specific values
  dplyr::mutate(
    color_arg = dplyr::case_when(
      Source == "English-language Jewish newspapers, magazines" ~ "1",
      Source == "Yiddish-language Jewish newspapers, magazines" ~ "1",
      Source == "Internet (unfiltered, unblocked)" ~ "2",
      Source == "Religious leaders - your rav, rosh yeshiva/rebbeim, shul rabbi, etc." ~ "3",
      Source == "Social Media (WhatsApp, Facebook, Twitter, Instagram, etc.)" ~ "4",
      TRUE ~ "5"
    ),
    bold_text = color_arg %in% c("1", "2", "3"),
    Source_wrapped = stringr::str_wrap(Source, width = 35)
  ) |>
  # Ensure "Other - Please describe" is at the bottom
  dplyr::mutate(
    Source_order = dplyr::case_when(
      Source == "Other - Please describe" ~ -Inf,
      TRUE ~ Percent
    )
  ) |>
  dplyr::arrange(Group, desc(Source_order)) |>
  dplyr::mutate(
    name = tidytext::reorder_within(Source_wrapped, Source_order, Group)
  )

# Visualize the data
# Main Visual with adjusted ordering
ggplot(
  data = dt_viz,
  mapping = aes(
    y = name,
    x = Percent,
    group = Group,
    fill = color_arg,
    label = ifelse(Percent >= 0.01, scales::percent(Percent, accuracy = 1), "<1%")
  )
) +
  theme_minimal(base_size = 14) +
  geom_bar(stat = "identity", width = 0.7, color = "white") +
  geom_text(
    data = dt_viz |> filter(Percent >= 0.01),
    mapping = aes(
      y = name,
      x = Percent,
      group = Group,
      label = scales::percent(Percent, accuracy = 1)
    ),
    position = position_stack(vjust = 0.5),
    color = "black",
    size = 4
  ) +
  geom_text(
    data = dt_viz |> filter(Percent < 0.01),
    mapping = aes(
      y = name,
      x = Percent,
      group = Group,
      label = "<1%"
    ),
    nudge_x = 0.04,
    color = "black",
    size = 4
  ) +
  geom_vline(xintercept = 0, size = 0.5, color = "gray70", linetype = "dashed") +
  tidytext::scale_y_reordered() +
  facet_wrap(~ Group, scales = "free_y", ncol = 2, strip.position = "top") +
  scale_fill_manual(values = c("#FFDD44", "#55AA88", "#44B5FF","#FF4081", "#C4C4C4")) +
  labs(
    caption = "Source: Nishma Research (2023); Reproduced by DataSense (2024)",
    title = "Sources of Voting Information:",
    subtitle = "Comparison between Haredi and Modern Orthodox Voters"
  ) +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    axis.ticks.x = element_blank(),
    axis.text.x = element_blank(),
    axis.text.y = element_text(hjust = 0.5, size = 12),
    legend.position = "none",
    strip.text = element_text(size = 14, face = "bold", color = "gray30"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    plot.caption = element_text(size = 10, color = "gray50", hjust = 1),
    plot.title = element_text(hjust = 0.5, size = 18, face = "bold"),
    plot.subtitle = element_text(hjust = 0.5, size = 14, color = "gray30")
  )
