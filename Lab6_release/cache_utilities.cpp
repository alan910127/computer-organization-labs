#include "cache_utilities.h"

#include <vector>
#include <algorithm>

using namespace std;

Block::Block() : is_valid{ false } {}
Block::Block(bool is_valid, uint32_t tag) : is_valid{ is_valid }, tag{ tag } {}
bool Block::operator==(uint32_t tag) { return this->is_valid and this->tag == tag; }

Set::Set(size_t N) : way(N), counter{ 0 }, use(N, 0) {}


/**
 * @brief add a block to an associative set
 *
 * @param tag tag to put
 * @return true cache hit occurred
 * @return false cache miss occurred
 */
bool Set::add_block(uint32_t tag) {
    auto it = find(blocks.begin(), blocks.end(), tag);
    if (it != blocks.end()) {
        update_use(distance(blocks.begin(), it));
        return true;
    }

    if (blocks.size() < way) {
        blocks.emplace_back(true, tag);
        update_use(blocks.size() - 1);
    }
    else {
        auto lru = find_lru();
        blocks[lru].is_valid = true;
        blocks[lru].tag = tag;
        update_use(lru);
    }
    return false;
}

size_t Set::find_lru() {
    return min_element(use.begin(), use.end()) - use.begin();
}

void Set::update_use(size_t index) {
    use[index] = ++counter;
}

/**
 * @brief Get the number of bits needed for indexing (size) of items
 *
 * @param size number of items that need to be indexed
 * @return the least number of bits needed
 */
int get_indexing_size(int size) {
    int num_bits = 0;
    while (size > (1 << num_bits)) ++num_bits;
    return num_bits;
}

/**
 * @brief Get the bits in range
 *
 * @param value the data we want to extract bits
 * @param offset the starting bit (inclusive)
 * @param bit_length the number of bits
 * @return the bits in range with the offset adjusted
 */
uint32_t get_bits(uint32_t value, int offset, int bit_length) {
    uint32_t mask = (1u << bit_length) - 1;
    value >>= offset;
    return value & mask;
}
