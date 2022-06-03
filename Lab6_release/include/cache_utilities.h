#pragma once

#include <vector>
#include <cstdint>

struct Block {
    bool is_valid;
    uint32_t tag;
    Block();
    Block(bool is_valid, uint32_t tag);
    bool operator==(uint32_t tag);
};

struct Set {
    Set(size_t N);
    bool add_block(uint32_t tag);
    size_t find_lru();
    void update_use(size_t index);

    size_t way;
    size_t counter;
    std::vector<Block> blocks;
    std::vector<size_t> use;
};

int get_indexing_size(int size);
uint32_t get_bits(uint32_t value, int offset, int bit_length);
