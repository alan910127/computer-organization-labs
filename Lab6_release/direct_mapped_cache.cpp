#include "direct_mapped_cache.h"
#include <string>
#include <fstream>
#include <vector>
#include <bitset>
#include <iomanip>

using namespace std;

Block::Block() : is_valid{ false } {}

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
    uint32_t mask = ~(0xffffffffu << (bit_length));
    value >>= offset;
    return value & mask;
}

/**
 * @brief Perform the direct mapped cache and calculate the hit rate
 *
 * @param filename the file to specified the accessing sequence
 * @param block_size size of a block in byte
 * @param cache_size size of the cache in byte
 * @return hit rate
 */
float direct_mapped(string filename, int block_size, int cache_size) {

    constexpr int ADDRESS_SIZE = 32;

    int total_num = 0;
    int hit_num = 0;

    int number_blocks = cache_size / block_size;

    int block_offset_size = get_indexing_size(block_size);
    int index_size = get_indexing_size(number_blocks);
    int tag_size = ADDRESS_SIZE - block_offset_size - index_size;

    int index_offset = block_offset_size;
    int tag_offset = block_offset_size + index_size;

    vector<Block> cache(number_blocks);

    ifstream file{ filename };

    uint32_t address;
    while (file >> hex >> address) {
        auto index = get_bits(address, index_offset, index_size);
        auto tag = get_bits(address, tag_offset, tag_offset);

        Block& block = cache[index];

        if (not block.is_valid or block.tag != tag) { // currently not used or used by others
            block.tag = tag;
            block.is_valid = true;
        }
        else {
            ++hit_num;
        }
        ++total_num;
    }

    return static_cast<float>(hit_num) / total_num;
}
