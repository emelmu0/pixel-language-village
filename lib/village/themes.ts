// PRD 14.2 마을 테마 목록 중 MVP 단계에서 사용할 일부.
// 프로필 생성(정확히는 첫 마을 방문) 시 이 중 하나가 랜덤으로 배정된다.

export type VillageTheme = {
  key: string;
  name: string;
  emoji: string;
  buildingEmoji: string;
  natureEmoji: string;
  buildingImage: string;
  natureImage: string;
};

export const VILLAGE_THEMES: VillageTheme[] = [
  { key: "ocean_kingdom", name: "바닷속 왕국", emoji: "🐠", buildingEmoji: "🏰", natureEmoji: "🪸", buildingImage: "/pixel-art/village/ocean_kingdom_building.png", natureImage: "/pixel-art/village/ocean_kingdom_nature.png" },
  { key: "medieval_kingdom", name: "중세 왕국", emoji: "🏰", buildingEmoji: "🏯", natureEmoji: "🌳", buildingImage: "/pixel-art/village/medieval_kingdom_building.png", natureImage: "/pixel-art/village/medieval_kingdom_nature.png" },
  { key: "korean_village", name: "한국 옛마을", emoji: "🏯", buildingEmoji: "🏠", natureEmoji: "🌾", buildingImage: "/pixel-art/village/korean_village_building.png", natureImage: "/pixel-art/village/korean_village_nature.png" },
  { key: "modern_city", name: "현대 도시", emoji: "🏙️", buildingEmoji: "🏢", natureEmoji: "🌳", buildingImage: "/pixel-art/village/modern_city_building.png", natureImage: "/pixel-art/village/modern_city_nature.png" },
  { key: "alien_planet", name: "외계 행성", emoji: "👽", buildingEmoji: "🛸", natureEmoji: "🌌", buildingImage: "/pixel-art/village/alien_planet_building.png", natureImage: "/pixel-art/village/alien_planet_nature.png" },
  { key: "moonlight_village", name: "달빛 마을", emoji: "🌙", buildingEmoji: "🏡", natureEmoji: "⭐", buildingImage: "/pixel-art/village/moonlight_village_building.png", natureImage: "/pixel-art/village/moonlight_village_nature.png" },
  { key: "cloud_village", name: "구름 위 마을", emoji: "☁️", buildingEmoji: "🏠", natureEmoji: "☁️", buildingImage: "/pixel-art/village/cloud_village_building.png", natureImage: "/pixel-art/village/cloud_village_nature.png" },
  { key: "world_tree_village", name: "세계수 마을", emoji: "🌳", buildingEmoji: "🏡", natureEmoji: "🍃", buildingImage: "/pixel-art/village/world_tree_village_building.png", natureImage: "/pixel-art/village/world_tree_village_nature.png" },
  { key: "mushroom_forest", name: "버섯 숲", emoji: "🍄", buildingEmoji: "🍄", natureEmoji: "🌲", buildingImage: "/pixel-art/village/mushroom_forest_building.png", natureImage: "/pixel-art/village/mushroom_forest_nature.png" },
  { key: "snow_village", name: "눈과 얼음 마을", emoji: "❄️", buildingEmoji: "🏠", natureEmoji: "⛄", buildingImage: "/pixel-art/village/snow_village_building.png", natureImage: "/pixel-art/village/snow_village_nature.png" },
  { key: "desert_oasis", name: "사막 오아시스", emoji: "🏜️", buildingEmoji: "⛺", natureEmoji: "🌴", buildingImage: "/pixel-art/village/desert_oasis_building.png", natureImage: "/pixel-art/village/desert_oasis_nature.png" },
  { key: "cat_village", name: "고양이 마을", emoji: "🐱", buildingEmoji: "🏠", natureEmoji: "🐾", buildingImage: "/pixel-art/village/cat_village_building.png", natureImage: "/pixel-art/village/cat_village_nature.png" },
];

export function pickRandomTheme(): VillageTheme {
  const index = Math.floor(Math.random() * VILLAGE_THEMES.length);
  return VILLAGE_THEMES[index];
}

export function getThemeByKey(key: string): VillageTheme {
  return VILLAGE_THEMES.find((t) => t.key === key) ?? VILLAGE_THEMES[0];
}

// 성장 규칙(PRD 14.3): 정확한 숫자는 추후 조정 가능하도록 한 곳에 모아둔다.
export const WORDS_PER_LEVEL = 5;

export function calcVillageLevel(masteredWordCount: number): number {
  return Math.floor(masteredWordCount / WORDS_PER_LEVEL) + 1;
}
