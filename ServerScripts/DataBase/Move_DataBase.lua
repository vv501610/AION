return {
    ['개인 사냥터'] = {

        ['초심자의 숲'] = {
            explanation = "강력한 몬스터들을 주의하세요!",
            img = "사냥터 (14).png",
            bool = 0,

            data = {
                ['쉬움'] = {
                    MonsterDataID = {10},
                    MonsterCount = {20},
                    MapData = {m = 4, x = 8,  y = 8, rmx = 2, rmy = 4, mmx = 28, mmy = 27} -- 맵 아이디, x축 , y축, 몬스터 소환 x축 크기, 몬스터 소환 y축 크기
                },
                ['보통'] = {
                    MonsterDataID = {1, 0},
                    MonsterCount = {5, 5},
                    MapData = {m = 4, x = 8,  y = 8, rmx = 0, rmy = 0, mmx = 29, mmy = 29} -- 맵 아이디, x축 , y축, 몬스터 소환 x축 크기, 몬스터 소환 y축 크기
                },
                ['어려움'] = {
                    MonsterDataID = {1, 0},
                    MonsterCount = {5, 5},
                    MapData = {m = 4, x = 8,  y = 8, rmx = 0, rmy = 0, mmx = 29, mmy = 29} -- 맵 아이디, x축 , y축, 몬스터 소환 x축 크기, 몬스터 소환 y축 크기
                },
                ['아주 어려움'] = {
                    MonsterDataID = {1, 0},
                    MonsterCount = {5, 5},
                    MapData = {m = 4, x = 8,  y = 8, rmx = 0, rmy = 0, mmx = 29, mmy = 29} -- 맵 아이디, x축 , y축, 몬스터 소환 x축 크기, 몬스터 소환 y축 크기
                },
                ['지옥'] = {
                    MonsterDataID = {1, 0},
                    MonsterCount = {5, 5},
                    MapData = {m = 4, x = 8,  y = 8, rmx = 0, rmy = 0, mmx = 29, mmy = 29} -- 맵 아이디, x축 , y축, 몬스터 소환 x축 크기, 몬스터 소환 y축 크기
                },
            }
        },
        ['아시아 대륙'] = {
            explanation = "으악",
            img = "사냥터 (22).png",
            bool = 1500,
        
            data = {
                ['쉬움'] = {
                    MonsterDataID = {3, 4},
                    MonsterCount = {5, 5},
                    MapData = {m = 4, x = 8,  y = 8, rmx = 0, rmy = 0, mmx = 29, mmy = 29} -- 맵 아이디, x축 , y축, 몬스터 소환 x축 크기, 몬스터 소환 y축 크기
                }
            }
        },
        ['심연'] = {
            explanation = "으악",
            img = "사냥터 (12).png",
            bool = 2000,
        
            data = {
                ['쉬움'] = {
                    MonsterDataID = {5, 6},
                    MonsterCount = {5, 5},
                    MapData = {m = 4, x = 8,  y = 8, rmx = 0, rmy = 0, mmx = 29, mmy = 29} -- 맵 아이디, x축 , y축, 몬스터 소환 x축 크기, 몬스터 소환 y축 크기
                }
            }
        },
        ['마법공학 도시'] = {
            explanation = "으악",
            img = "사냥터 (18).png",
            bool = 3000,
        
            data = {
                ['쉬움'] = {
                    MonsterDataID = {7, 8},
                    MonsterCount = {5, 5},

                    MapData = {m = 4, x = 8,  y = 8, rmx = 0, rmy = 0, mmx = 29, mmy = 29} -- 맵 아이디, x축 , y축, 몬스터 소환 x축 크기, 몬스터 소환 y축 크기
                }
            }
        },
    },
    
    ['컨텐츠'] = {

        data = {
            ['낚시터'] = {
                type = true, -- type이 true일경우 인스턴트맵 생상하지 말고 기존 오픈월드로 이동 이떄는 걍 어디로 이동하는지 정보만 있음됨

                MonsterDataID = {1, 2},

                MapData = {
                    [1] = {m = 2, x = 42,  y = 30, rmx = 32, rmy = 32}, -- 맵 아이디, x축 , y축, 몬스터 소환 x축 크기, 몬스터 소환 y축 크기
                    [2] = {m = 4, x = 8,  y = 8, rmx = 32, rmy = 32},
                },

            },

            ['방치'] = {
                type = true, -- type이 true일경우 인스턴트맵 생상하지 말고 기존 오픈월드로 이동
                
                MonsterDataID = {3, 4},

                MapData = {
                    [1] = {m = 4, x = 8,  y = 8, rmx = 32, rmy = 32}, -- 맵 아이디, x축 , y축
                    [2] = {m = 4, x = 8,  y = 8, rmx = 32, rmy = 32},
                },
            },
        }
        
    }
}

