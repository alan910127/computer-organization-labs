#pragma once

#include <iostream>
#include <string>

struct Block {
    bool is_valid;
    uint32_t tag;
    Block();
};

int get_indexing_size(int size);
uint32_t get_bits(uint32_t value, int left, int right);
float direct_mapped(std::string file, int block_size, int cache_size);
