// PRD 14.2 마을 테마 목록 중 MVP 단계에서 사용할 일부.
// 프로필 생성(정확히는 첫 마을 방문) 시 이 중 하나가 랜덤으로 배정된다.

export type VillageTheme = {
  key: string;
  name: string;
  emoji: string;
  buildingEmoji: string;
  natureEmoji: string;
};

export const VILLAGE_THEMES: VillageTheme[] = [
  { key: "ocean_kingdom", name: "바닷속 왕국", emoji: "🐠", buildingEmoji: "🏰", natureEmoji: "🪸" },
  { key: "medieval_kingdom", name: "중세 왕국", emoji: "🏰", buildingEmoji: "🏯", natureEmoji: "🌳" },
  { key: "korean_village", name: "한국 옛마을", emoji: "🏯", buildingEmoji: "🏠", natureEmoji: "🌾" },
  { key: "modern_city", name: "현대 도시", emoji: "🏙️", buildingEmoji: "🏢", natureEmoji: "🌳" },
  { key: "alien_planet", name: "외계 행성", emoji: "👽", buildingEmoji: "🛸", natureEmoji: "🌌" },
  { key: "moonlight_village", name: "달빛 마을", emoji: "🌙", buildingEmoji: "🏡", natureEmoji: "⭐" },
  { key: "cloud_village", name: "구름 위 마을", emoji: "☁️", buildingEmoji: "🏠", natureEmoji: "☁️" },
  { key: "world_tree_village", name: "세계수 마을", emoji: "🌳", buildingEmoji: "🏡", natureEmoji: "🍃" },
  { key: "mushroom_forest", name: "버섯 숲", emoji: "🍄", buildingEmoji: "🍄", natureEmoji: "🌲" },
  { key: "snow_village", name: "눈과 얼음 마을", emoji: "❄️", buildingEmoji: "🏠", natureEmoji: "⛄" },
  { key: "desert_oasis", name: "사막 오아시스", emoji: "🏜️", buildingEmoji: "⛺", natureEmoji: "🌴" },
  { key: "cat_village", name: "고양이 마을", emoji: "🐱", buildingEmoji: "🏠", natureEmoji: "🐾" },
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
