#pragma once

#include <iostream>
#include <string>

/**
 * @brief Perform the direct mapped cache and calculate the hit rate
 *
 * @param filename the file to specified the accessing sequence
 * @param block_size size of a block in byte
 * @param cache_size size of the cache in byte
 * @return hit rate
 */
float direct_mapped(std::string file, int block_size, int cache_size);
